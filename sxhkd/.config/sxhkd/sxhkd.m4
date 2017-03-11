divert -1
define(`INCLUDE_CMDS', `include(WM`_cmds.m4')')
divert

INCLUDE_CMDS
include(`defaults.sxhkd')
include(`launch.sxhkd')
include(`xf86.sxhkd')

super + shift + c
    KILL_WINDOW

super + button2
    FULLSCREEN

super + space
    FULLSCREEN

super + {Left, Down, Up, Right}
    MOVE

super + shift + {Left, Down, Up, Right}
    MOVE_FAST

super + alt + {Left, Down, Up, Right}
    RESIZE

super + shift + alt + {Left, Down, Up, Right}
    RESIZE_FAST

super + button4
    NEXT_WINDOW

super + button5
    PREVIOUS_WINDOW

super + j
    NEXT_WINDOW

super + k
    PREVIOUS_WINDOW

super + shift + {h,j,k,l}
    SNAP_ORTHO

super + shift + {y,u,n,m}
    SNAP_DIAG

