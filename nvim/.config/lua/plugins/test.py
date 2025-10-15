# -*- coding: utf-8 -*-
#
# ===================================================================
# 🎨 Python Syntax Highlighting Showcase
# ===================================================================
# This file is designed to display as many Python syntax
# elements as possible to test a color scheme in a text editor.

# --- 1. Imports ---
# Keywords `import`, `from`, `as`
import os
import re
from typing import List, Dict, Any, Union, Tuple


# --- 2. Decorator Definition ---
# Decorator syntax `@`
def syntax_decorator(cls):
    """A sample decorator to highlight decorator syntax."""
    cls.decorated = True
    return cls


# --- 3. Class Definition ---
# Keyword `class`, inheritance `(object)`, special methods `__init__`
@syntax_decorator
class SyntaxShowcase(object):
    """
    A class demonstrating various syntax elements including:
    - Triple-quoted docstrings
    - Class variables, constants
    - Methods with type hinting
    """

    # --- Class Constants & Variables ---
    # Boolean and None literals, which are often highlighted as constants.
    A_BOOLEAN_CONSTANT: bool = True
    A_NONE_CONSTANT = None
    A_NUMERIC_CONSTANT = 1_000_000  # Number with separator

    def __init__(self, name: str, items: List[any] = None):
        # `self` keyword, parameters with types and default values
        self.name: str = name  # String literal
        self.items = items or []
        # --- Numeric Literals ---
        self._integer: int = 42
        self._float: float = 3.14159e-5
        self._hexadecimal = 0xDEADBEEF
        self._octal = 0o755
        self._binary = 0b10101010

    # --- Methods & Control Flow ---
    # Keywords `async def`, `await`, `->` for return type hints
    async def process_data(self, config: Dict[str, Union[int, str]]) -> Tuple[int, str]:
        """
        An async method to show async/await, f-strings, and operators.
        """
        # --- f-string and String Literals ---
        # f-strings often have special highlighting for embedded expressions.
        print(f"Processing data for '{self.name}'...")
        byte_string = b"some raw bytes"
        raw_string = r"C:\Users\Test\Path"

        # --- Operators and Control Flow (`if`/`elif`/`else`) ---
        # Comparison `is not`, logical `and`, arithmetic `*`, bitwise `|`
        if self._integer is not None and self._integer > 0:
            result = self._integer * 2 | self._binary
        elif "timeout" in config:
            result = config.get("timeout")
        else:
            result = 0

        # Await a placeholder async function
        await self._some_async_operation()

        return (result, "Completed")

    # --- Looping and Exception Handling ---
    # Keywords `for`, `in`, `try`, `except`, `finally`, `raise`, `as`
    def loop_and_handle_errors(self):
        # `for` loop, keyword `in`, built-in function `range`
        for i in range(len(self.items)):
            try:
                # `while` loop, keyword `continue`
                while i < 5:
                    i += 1
                    continue
                # Keyword `raise`, built-in `Exception` type
                if self.items[i] == "error":
                    raise ValueError(f"Found an error at index {i}")
            # Keywords `except`, `as`
            except (ValueError, IndexError) as e:
                print(f"Caught an exception: {e!r}")
                # Keyword `break`
                break
            # Keyword `finally`
            finally:
                # Keyword `pass`
                pass

    async def _some_async_operation(self):
        # A dummy async function
        return


# --- 4. Standalone Function & Advanced Features ---
def global_function(numbers: List[int]):
    """Demonstrates comprehensions, lambdas, and context managers."""
    # --- Comprehensions ---
    list_comp = [n**2 for n in numbers if n % 2 == 0]
    dict_comp = {n: str(n) for n in list_comp}
    set_comp = {n for n in numbers}

    # --- Lambda Function ---
    # Keyword `lambda`
    add_one = lambda x: x + 1
    print(add_one(10))

    # --- Context Manager ---
    # Keywords `with`, `as`
    try:
        with open(os.devnull, "w") as f:
            f.write("This goes to nowhere.\n")
    except IOError:
        pass  # Handle potential error

    # --- Regular Expression String ---
    # Regex patterns often get special string highlighting.
    regex_pattern = r"^(\d{4}-\d{2}-\d{2})\s.*$"
    re.search(regex_pattern, "2023-10-27 some text")


# --- 5. Script Execution Entry Point ---
# Special variable `__name__`, often highlighted differently
if __name__ == "__main__":
    showcase_instance = SyntaxShowcase(name="Demo", items=[1, 2, "error", 4])
    showcase_instance.loop_and_handle_errors()
    global_function([1, 2, 3, 4, 5, 6])
