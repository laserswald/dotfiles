set-face global Default default
set-face global error yellow,red+b

evaluate-commands %sh{
	similar="black"
    bsimilar="black+b"
	contrast="white"
	bcontrast="white+b"

	face () {
		printf "set-face global %s %s\n" $1 $2
	}

	face_group () {
	    color=$1
	    shift
	    for i in $@; do
	        face "$i" "$color"
	    done
	}

	face_group $similar meta
	face_group $bsimilar comment
	face_group $contrast string value
	face_group $bcontrast 'function' type module
	face_group default attribute keyword variable operator 
}

set-face global BufferPadding black,default

set-face global StatusLine white,black+i

set-face global PrimarySelection black,white
set-face global SecondarySelection black,white
set-face global PrimaryCursor black+rb
set-face global SecondaryCursor default+r
set-face global PrimaryCursorEol black+rb
set-face global SecondaryCursorEol default+r

set-face global LineNumbers black
set-face global LineNumberCursor black+b
set-face global LineNumbersWrapped black

set-face global MenuForeground white,black
set-face global MenuBackground black,white
set-face global MenuInfo black,white+b

set-face global Information white,black+b
