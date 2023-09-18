divert(-1)
define(`define_default', `ifdef(`$1', `', `define(`$1', `$2')')')

define(`THEME_HOME', `~/.config/alacritty')
define_default(`_SHADE', `dark')
define_default(`_THEME_NAME', `selenized_hi')

define(`define_font', `
	define_default(`_FONT', $1)
	define_default(`_FONT_SIZE', $2)
')

define(`define_dark_light_theme', `
	ifelse(
		_SHADE, `dark',
			`define_default(`_THEME', $1)',
		_SHADE, `light',
			`define_default(`_THEME', $2)'
	)
')

ifelse(
    _THEME_NAME, `selenized_hi',
		`define_dark_light_theme(`THEME_HOME/selenized/black.yml', `THEME_HOME/selenized/white.yml')',

    _THEME_NAME, `selenized_lo',
		`define_dark_light_theme(`THEME_HOME/selenized/dark.yml', `THEME_HOME/selenized/light.yml')',

    _THEME_NAME, `pencil',
        `define_dark_light_theme(`THEME_HOME/pencil_dark.yaml', `THEME_HOME/pencil_light.yaml')',

    _THEME_NAME, `catppuccin_hi',
		`define_dark_light_theme(`THEME_HOME/catppuccin/catppuccin-macchiato.yml', `THEME_HOME/catppuccin/catppuccin-latte.yml')'
)
# define_default(`_THEME', `THEME_HOME/tomorrow_night_bright.yml')


define_font(`FiraCode Nerd Font', `13')
# define_font(`Monoid Nerd Font Retina', `13')
# define_font(`CMUTypewriter NF', `16')

divert(0)dnl
