divert(-1)

define(`define_default', `ifdef(`$1', `', `define(`$1', `$2')')')

define(`THEME_HOME', `~/.config/alacritty/themes')

define(`define_font', `
	define_default(`_FONT', $1)
	define_default(`_FONT_SIZE', $2)
')

define_default(`_THEME', `THEME_HOME/_THEME_NAME.toml')

# define_font(`CMUTypewriter NF', `16')
define_font(`Fira Code', `13')
define_font(`Terminess Nerd Font', `13')
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
