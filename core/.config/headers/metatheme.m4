divert(-1)
# 
# Many programs I prefer like to use header files as their main configuration avenue,
# but keeping the whole theme consistent is a big bother.
# 

#define HTHEME_FONT "Hack:pixelsize=14:antialias=true" */
#define HTHEME_FONT "Fira Code:pixelsize=14:antialias=true" */
#define HTHEME_FONT "Fira Code Nerd Font:pixelsize=13:antialias=true"
#define HTHEME_FONT "Monoid:pixelsize=12:antialias=true" */
#define HTHEME_FONT "Fixed:style=regular:pixelsize=10" */
#define HTHEME_FONT "xos4 Terminus:pixelsize=11" */
#define HTHEME_FONT "benis uushi:pixelsize=12" */
#define HTHEME_FONT "Cozette:pixelsize=12" */

define(`METATHEME_FONT_FAMILY', `Fira Code Nerd Font')
define(`METATHEME_FONT_PXSIZE', 13)

define(`METATHEME_FONT',`METATHEME_FONT_FAMILY:pixelsize=METATHEME_FONT_PXSIZE:antialias=true')
define(METATHEME_THEME_BRIGHTNESS, DARK)
include(`themes/gruvbox-core.m4')
define(`MT_RGB', `#'$1)
divert(0)dnl
