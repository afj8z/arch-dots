#!/usr/bin/env python3
"""
Simple Theme Templating Engine
Generates theme files by substituting {{ key | fallback @func(args) }} patterns.
"""

import re
import json
import argparse
import sys
from pathlib import Path
from typing import Any, Dict, Optional, Tuple

# -- COLOR UTILITIES --


def parse_hex(hex_str: str) -> Tuple[int, int, int]:
    """Converts #RRGGBB to (r, g, b)."""
    hex_str = hex_str.lstrip("#")
    if len(hex_str) != 6:
        raise ValueError(f"Invalid hex color: {hex_str}")
    return tuple(int(hex_str[i : i + 2], 16) for i in (0, 2, 4))


def to_hex(rgb: Tuple[int, int, int]) -> str:
    """Converts (r, g, b) to #RRGGBB."""
    return "#{:02x}{:02x}{:02x}".format(*rgb)


# -- TRANSFORM FUNCTIONS (@func) --


class Transformers:
    """Namespace for template functions (prefixed with @ in template)."""

    @staticmethod
    def rgb(value: str, *args) -> str:
        """
        Converts #RRGGBB to 'R, G, B'.
        Usage: @rgb
        """
        r, g, b = parse_hex(value)
        return f"{r}, {g}, {b}"

    @staticmethod
    def transparent(value: str, alpha: str) -> str:
        """
        Converts #RRGGBB (or 'R,G,B') to rgba(R, G, B, A) or similar.
        Usage: @transparent(0.96)
        """
        # Handle inputs that are already comma-separated RGB
        if "," in value and "#" not in value:
            clean_val = value
        else:
            r, g, b = parse_hex(value)
            clean_val = f"{r}, {g}, {b}"

        return f"rgba({clean_val}, {alpha})"

    @staticmethod
    def hex(value: str, *args) -> str:
        """Ensures output is hex (idempotent)."""
        if value.startswith("#"):
            return value
        # Basic handler for comma separated string back to hex if needed
        parts = [int(x.strip()) for x in value.split(",")]
        return to_hex((parts[0], parts[1], parts[2]))


# -- CORE ENGINE --


class TemplateEngine:
    # Regex to match {{ ... }} content
    PATTERN = re.compile(r"\{\{(.*?)\}\}")
    # Regex to capture @func(args) or @func
    FUNC_PATTERN = re.compile(r"@(\w+)(?:\(([^)]+)\))?")

    def __init__(self, palette: Dict[str, Any]):
        self.palette = palette
        self.transformers = Transformers()

    def get_value(self, key: str) -> Optional[str]:
        """
        Resolves a key in the palette. Supports dot notation (e.g., 'state.active').
        """
        key = key.strip()

        # 1. Try direct exact match
        if key in self.palette:
            return str(self.palette[key])

        # 2. Try nested lookup (state.active -> palette['state']['active'])
        if "." in key:
            parts = key.split(".")
            curr = self.palette
            try:
                for part in parts:
                    if isinstance(curr, dict) and part in curr:
                        curr = curr[part]
                    else:
                        return None
                return str(curr)
            except (TypeError, AttributeError):
                return None
        return None

    def apply_function(self, value: str, func_str: str) -> str:
        """Parses and applies a single function string like '@transparent(0.5)'."""
        match = self.FUNC_PATTERN.match(func_str)
        if not match:
            return value  # Return raw if parse fails

        name, args_str = match.groups()

        if not hasattr(self.transformers, name):
            print(f"Warning: Unknown function @{name}", file=sys.stderr)
            return value

        func = getattr(self.transformers, name)

        args = [a.strip() for a in args_str.split(",")] if args_str else []
        try:
            return func(value, *args)
        except Exception as e:
            print(f"Error applying @{name} to '{value}': {e}", file=sys.stderr)
            return value

    def process_match(self, match: re.Match) -> str:
        content = match.group(1).strip()

        # 1. Separate Pipeline from Functions
        # Strategy: Find the first '@' that isn't part of a fallback chain?
        # Actually, split by space and look for tokens starting with @ at the end
        tokens = content.split()

        funcs = []
        candidates_chunk = []

        # Walk backwards to identify function chain
        for token in reversed(tokens):
            if token.startswith("@"):
                funcs.insert(0, token)
            else:
                # Stop once we hit non-function tokens
                # Reconstruct the candidate string
                idx = tokens.index(token)
                candidates_chunk = tokens[: idx + 1]
                break

        if not candidates_chunk:  # Case where it might be empty or just functions
            candidates_chunk = tokens if not funcs else []

        candidate_str = " ".join(candidates_chunk)

        # 2. Resolve Candidate (Fallback Logic)
        # Handle both | and || as OR operators
        keys = [k.strip() for k in re.split(r"\|+", candidate_str)]

        resolved_value = None
        for k in keys:
            val = self.get_value(k)
            if val:
                resolved_value = val
                break

        # If no key found, check if the last fallback is a literal (optional feature)
        # For now, strict: if not found, leave template or replace with empty?
        # Assuming we leave it visible to indicate error, or empty.
        if resolved_value is None:
            print(
                f"Warning: No value found for chain '{candidate_str}'", file=sys.stderr
            )
            return match.group(0)  # Return original tag matched

        # 3. Apply Function Chain
        final_value = resolved_value
        for f in funcs:
            final_value = self.apply_function(final_value, f)

        return final_value

    def render(self, text: str) -> str:
        return self.PATTERN.sub(self.process_match, text)


# -- MAIN EXECUTION --


def main():
    parser = argparse.ArgumentParser(description="Theme Template Generator")
    parser.add_argument("palette", type=Path, help="Path to JSON palette file")
    parser.add_argument(
        "template_dir",
        nargs="?",
        default="_template",
        type=Path,
        help="Source template directory",
    )
    parser.add_argument(
        "output_dir",
        nargs="?",
        default="generated_theme",
        type=Path,
        help="Destination directory",
    )

    args = parser.parse_args()

    if not args.palette.exists():
        sys.exit(f"Error: Palette file {args.palette} not found.")

    if not args.template_dir.exists():
        sys.exit(f"Error: Template directory {args.template_dir} not found.")

    # Load Palette
    with open(args.palette, "r") as f:
        try:
            palette = json.load(f)
        except json.JSONDecodeError as e:
            sys.exit(f"Error parsing JSON palette: {e}")

    engine = TemplateEngine(palette)

    # Create Output Dir
    args.output_dir.mkdir(parents=True, exist_ok=True)
    print(f":: Generating theme in '{args.output_dir}' using '{args.palette}'...")

    # Process Files
    for template_file in args.template_dir.rglob("*"):
        if template_file.is_dir():
            continue

        rel_path = template_file.relative_to(args.template_dir)
        dest_file = args.output_dir / rel_path

        dest_file.parent.mkdir(parents=True, exist_ok=True)

        try:
            # Attempt to read as text
            content = template_file.read_text(encoding="utf-8")
            rendered = engine.render(content)
            dest_file.write_text(rendered, encoding="utf-8")
            print(f"   [OK] {rel_path}")
        except UnicodeDecodeError:
            # Binary file fallback: copy directly
            dest_file.write_bytes(template_file.read_bytes())
            print(f"   [CP] {rel_path} (Binary copy)")


if __name__ == "__main__":
    main()
