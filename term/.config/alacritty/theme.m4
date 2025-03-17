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
		`define_dark_light_theme(`THEME_HOME/selenized/black.toml', `THEME_HOME/selenized/white.toml')',

    _THEME_NAME, `selenized_lo',
		`define_dark_light_theme(`THEME_HOME/selenized/dark.toml', `THEME_HOME/selenized/light.toml')',

    _THEME_NAME, `pencil',
        `define_dark_light_theme(`THEME_HOME/pencil_dark.toml', `THEME_HOME/pencil_light.toml')',

    _THEME_NAME, `catppuccin_hi',
		`define_dark_light_theme(`THEME_HOME/catppuccin/catppuccin-macchiato.toml', `THEME_HOME/catppuccin/catppuccin-latte.toml')'
)

# define_default(`_THEME', `THEME_HOME/tomorrow_night_bright.toml')

# define_font(`CMUTypewriter NF', `16')
define_font(`FiraCode Nerd Font', `13')
# define_font(`Hack', `13')
# define_font(`IBM Plex Mono', `13')
# define_font(`Inconsolata Nerd Font', `13')
# define_font(`Iosevka Nerd Font', `13')
# define_font(`Latin Modern Mono', `13')
# define_font(`Monoid Nerd Font Retina', `13')
# define_font(`Proggy Clean', `13')
# define_font(`Proggy Vector', `13')
# define_font(`TerminessTTF NF', `13')

divert(0)dnl
