
/* Terminal colors (16 first used in escape sequence) */
const char *colorname[] = {
	/* 8 normal colors */
	"#414141",
	"#a84c3d",
	"#3f8250",
	"#94813b",
	"#3d52b5",
	"#a641a6",
	"#3a9085",
	"#acacac",

	/* 8 bright colors */
	"#5c5c5c",
	"#bb6b42",
	"#619b5d",
	"#b1b95c",
	"#4e93cf",
	"#be6187",
	"#66c9a2",
	"#eeeeee",

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	"#1f1f1f",
	"#cccccc",
	"#000000",
	"#ffffff",
};

