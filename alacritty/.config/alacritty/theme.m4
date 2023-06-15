divert(-1)
define(`THEME_HOME', `~/.config/alacritty')

define(`define_default', `ifdef(`$1', `', `define(`$1', `$2')')')

define(`define_font', `
	define_default(`_FONT', $1)
	define_default(`_FONT_SIZE', $2)
')

define(`define_dark_light_theme', `
	ifdef(`_DARK_MODE',
		`define_default(`_THEME', $1)',
		`define_default(`_THEME', $2)'
    ) 
')

# define(`_DARK_MODE',`')

define_dark_light_theme(`THEME_HOME/selenized/black.yml', `THEME_HOME/selenized/white.yml')
# define_dark_light_theme(`THEME_HOME/selenized/dark.yml', `THEME_HOME/selenized/light.yml')
# define_dark_light_theme(`THEME_HOME/pencil_dark.yaml', `THEME_HOME/pencil_light.yaml')
# define_dark_light_theme(`THEME_HOME/catppuccin/catppuccin-macchiato.yml', `THEME_HOME/catppuccin/catppuccin-latte.yml')
# define_default(`_THEME', `THEME_HOME/tomorrow_night_bright.yml')

define_font(`FiraCode Nerd Font', `12')
# define_font(`CMUTypewriter NF', `14')
divert(0)dnl
