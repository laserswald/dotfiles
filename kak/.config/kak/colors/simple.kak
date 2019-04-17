face global Default default
face global error yellow,red+b

evaluate-commands %sh{
	similar="black"
    bsimilar="black+b"
	contrast="white"
	bcontrast="white+b"

	face () {
		printf "face global %s %s\n" $1 $2
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

face global BufferPadding black,default

face global StatusLine white,black+i

face global PrimarySelection black,white
face global SecondarySelection black,white
face global PrimaryCursor black+rb
face global SecondaryCursor default+r
face global PrimaryCursorEol black+rb
face global SecondaryCursorEol default+r

face global LineNumbers black
face global LineNumberCursor black+b
face global LineNumbersWrapped black

face global MenuForeground white,black
face global MenuBackground black,white
face global MenuInfo black,white+b

face global Information white,black+b
