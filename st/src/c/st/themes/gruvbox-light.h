/* gruvbox-light colorscheme */

static const char dark0_hard[]      = "#1D2021";
static const char dark0[]           = "#282828";
static const char dark0_soft[]      = "#32302F";
static const char dark1[]           = "#3C3836";
static const char dark2[]           = "#504945";
static const char dark3[]           = "#665C54";
static const char dark4[]           = "#7C6F64";

static const char gray_243[]        = "#7c6f64";
static const char gray_244[]        = "#928374";

static const char light0_hard[]     = "#F9F5D7";
static const char light0[]          = "#FBF1C7";
static const char light0_soft[]     = "#F2E5BC";
static const char light1[]          = "#EBDBB2";
static const char light2[]          = "#D5C4A1";
static const char light3[]          = "#BDAE93";
static const char light4[]          = "#A89984";

static const char bright_red[]      = "#FB4934";
static const char bright_green[]    = "#B8BB26";
static const char bright_yellow[]   = "#FABD2F";
static const char bright_blue[]     = "#83A598";
static const char bright_purple[]   = "#D3869B";
static const char bright_aqua[]     = "#8EC07C";
static const char bright_orange[]   = "#FE8019";

static const char neutral_red[]     = "#CC241D";
static const char neutral_green[]   = "#98971A";
static const char neutral_yellow[]  = "#D79921";
static const char neutral_blue[]    = "#458588";
static const char neutral_purple[]  = "#B16286";
static const char neutral_aqua[]    = "#689D6A";
static const char neutral_orange[]  = "#D65D0E";

static const char faded_red[]       = "#9D0006";
static const char faded_green[]     = "#79740E";
static const char faded_yellow[]    = "#B57614";
static const char faded_blue[]      = "#076678";
static const char faded_purple[]    = "#8F3F71";
static const char faded_aqua[]      = "#427B58";
static const char faded_orange[] = "#AF3A03";

/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {
	/* 8 normal colors */
	light0, /* hard contrast: #f9f5d7 / soft contrast: #f2e5bc */
	neutral_red,
	neutral_green,
	neutral_yellow,
	neutral_blue,
	neutral_purple,
	neutral_aqua,
	gray_243,

	/* 8 bright colors */
	gray_244,
	faded_red,
	faded_green,
	faded_yellow,
	faded_blue,
	faded_purple,
	faded_aqua,
	dark1,

	[255] = 0,
	[130] = faded_orange,
	[166] = neutral_orange,
	[229] = light0,
	[223] = light1, 
	[250] = light2,
	[248] = dark3,
	[246] = light4,
};

/*
 * Default colors (colorname index)
 * foreground, background, cursor, reverse cursor
 */
unsigned int defaultfg = 15;
unsigned int defaultbg = 0;
static unsigned int defaultcs = 15;
static unsigned int defaultrcs = 0;

