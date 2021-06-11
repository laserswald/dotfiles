divert(-1)
# 
# Many programs I prefer like to use header files as their main configuration avenue,
# but keeping the whole theme consistent is a big bother.
# 

# define(`METATHEME_FONT_FAMILY', `Hack')
# define(`METATHEME_FONT_FAMILY', `Fira Code')
define(`METATHEME_FONT_FAMILY', `Fira Code Nerd Font')
# define(`METATHEME_FONT_FAMILY', `Monoid')
# define(`METATHEME_FONT_FAMILY', `Fixed')
# define(`METATHEME_FONT_FAMILY', `xos4 Terminus')
# define(`METATHEME_FONT_FAMILY', `benis uushi')
# define(`METATHEME_FONT_FAMILY', `Cozette')


define(`METATHEME_FONT_PXSIZE', 13)

define(`METATHEME_FONT_STRING')

define(`METATHEME_FONT',`METATHEME_FONT_FAMILY:pixelsize=METATHEME_FONT_PXSIZE:antialias=true')
define(METATHEME_THEME_BRIGHTNESS, LIGHT)
define(GRUVBOX_HARDNESS, SOFT)
include(`themes/gruvbox-core.m4')
define(`MT_RGB', `#'$1)
divert(0)dnl
