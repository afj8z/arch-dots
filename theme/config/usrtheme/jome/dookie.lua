static char normbgcolor[]           = "#2e3440";
static char normbordercolor[]       = "#4c566a";
static char normfgcolor[]           = "#d8dee9";
static char selfgcolor[]            = "#eceff4";
static char selbordercolor[]        = "#a3be8c";
static char selbgcolor[]            = "#b48ead";
{
    "special": {
        "background": "#30272b",
        "foreground": "#925633",
        "cursor": "#bcb8ba"
    },
    "colors": {
        "color0": "#30272b",
        "color1": "#925633",
        "color2": "#d8a657",
        "color3": "#5e6676",
        "color4": "#978341",
        "color5": "#694e63",
        "color6": "#47676e",
        "color7": "#bcb8ba",
        "color8": "#443c40",
        "color9": "#925633",
        "color10": "#72761e",
        "color11": "#5e6676",
        "color12": "#978341",
        "color13": "#694e63",
        "color14": "#47676e",
        "color15": "#bcb8ba"
    },
    "checksum": "None",
    "wallpaper": "None",
    "alpha": "100"
}
{
    "special": {
        "background": "#2f2a2a",
        "foreground": "#ee9142",
        "cursor": "#332e2e"
    },
    "colors": {
        "color0": "#2f2a2a",
        "color1": "#99312c",
        "color2": "#5a986c",
        "color3": "#f1841b",
        "color4": "#e06412",
        "color5": "#915556",
        "color6": "#477578",
        "color7": "#c9c8c8",
        "color8": "#b2885d",
        "color9": "#854340",
        "color10": "#668c71",
        "color11": "#c1854b",
        "color12": "#bd5c1b",
        "color13": "#854340",
        "color14": "#41647b",
        "color15": "#b5bbd2"
    },
    "checksum": "None",
    "wallpaper": "None",
    "alpha": "100"
}


NEWLINE=$'\n'
PROMPT="${NEWLINE}%K{#2E3440}%F{#E5E9F0}$(date +%_I:%M%P) %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ %f%k ❯ " # nord theme
# PROMPT="${NEWLINE}%K{#32302f}%F{#d5c4a1} $0 %K{#3c3836}%F{#d5c4a1} %n %K{#504945} %~ %f%k ❯ " # warmer theme
# PROMPT="${NEWLINE}%K{$COL0}%F{$COL1}$(date +%_I:%M%P) %K{$COL0}%F{$COL2} %n %K{$COL3} %~ %f%k ❯ " # pywal colors, from postrun script

# echo -e "${NEWLINE}\033[48;2;46;52;64;38;2;216;222;233m $0 \033[0m\033[48;2;59;66;82;38;2;216;222;233m $(uptime -p | cut -c 4-) \033[0m\033[48;2;76;86;106;38;2;216;222;233m $(uname -r) \033[0m" # nord theme
# echo -e "${NEWLINE}\x1b[38;5;137m\x1b[48;5;0m it's$(date +%_I:%M%P) \x1b[38;5;180m\x1b[48;5;0m $(uptime -p | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m" # warmer theme
echo -e "${NEWLINE}\x1b[38;5;137m\x1b[48;5;0m it's$(print -P '%D{%_I:%M%P}\n') \x1b[38;5;180m\x1b[48;5;0m $(uptime -p | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m" # current

[global]
    monitor = 0
    follow = keyboard
    width = (250, 500)
    height = (0, 750)
    offset = (17, 26)
    padding = 5
    horizontal_padding = 5
    gap_size = 3
    transparency = 35
    frame_width = 1
    frame_color="#607566"
    font = Libertinus Mono 11
    corner_radius = 5
    min_icon_size = 32
    max_icon_size = 32
    format = "<b>%s</b>\n%b"

[urgency_low]
    foreground = "#0A2E15"
    background = "#68B351"
    timeout = 3

[urgency_normal]
    foreground = "#0A2E15"
    background = "#8FCE61"
    timeout = 5

[urgency_critical]
    background = "#C1CAC4"
    foreground = "#0A2E15"
    frame_color = "#ff0000"
    timeout = 15

static const char *colorname[] = {
// Nord Color Scheme
	/* 8 normal colors */
	"#3b4252", /* black   */
	"#bf616a", /* red     */
	"#a3be8c", /* green   */
	"#ebcb8b", /* yellow  */
	"#81a1c1", /* blue    */
	"#b48ead", /* magenta */
	"#88c0d0", /* cyan    */
	"#e5e9f0", /* white   */

	/* 8 bright colors */
	"#4c566a", /* black   */
	"#bf616a", /* red     */
	"#a3be8c", /* green   */
	"#ebcb8b", /* yellow  */
	"#81a1c1", /* blue    */
	"#b48ead", /* magenta */
	"#8fbcbb", /* cyan    */
	"#eceff4", /* white   */

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	"#d8dee9", /* default foreground colour */
	"#2e3440", /* default background colour */
};


shadow-color = "#393943" # this could be set with a pywal template instead

