
evaluate-commands %sh{
	similar="black+b"
	bsimilar="black"
	contrast="white"
	bcontrast="white+b"

	face () {
		printf 'face global %s %s\\n' $1 $2
	}

	face type $contrast
	face type $contrast
	face type $contrast
	face type $contrast
}

face global attribute black+be
face global builtin white+b
face global comment black
face global error yellow,red+b
face global function white+b
face global keyword white
face global meta
face global module red
face global operator default
face global string white+b
face global type white+b
face global value red
face global variable blue+e

face global Default default
face global PrimaryCursor default+r
face global PrimarySelection black,white
face global SecondaryCursor default+r
face global SecondarySelection black,white
face global LineNumbers black+e
face global LineNumberCursor blue+b
face global LineNumbersWrapped black+b
face global MenuForeground white,blue
face global MenuBackground blue,white
face global MenuInfo red,white
face global BufferPadding black,default
face global StatusLine cyan,black+i
