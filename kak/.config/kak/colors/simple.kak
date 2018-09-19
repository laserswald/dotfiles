face global Default default
face global error yellow,red+b

# comment

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
	        face $i $color
	    done
	}

	face_group $similar meta
	face_group magenta comment
	face_group $contrast string
	face_group $bcontrast 'function' type module

	face_group default attribute type keyword variable operator value
}

face global Default default
face global PrimaryCursor cyan+r
face global PrimarySelection black,white
face global BufferPadding black,default
face global StatusLine cyan,black+i


face global SecondaryCursor default+r
face global SecondarySelection black,white
face global LineNumbers black+e
face global LineNumberCursor blue+b
face global LineNumbersWrapped black+b
face global MenuForeground white,blue
face global MenuBackground blue,white
face global MenuInfo red,white
