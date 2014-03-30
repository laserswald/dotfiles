-- laserdude's xmonad.hs file.

-- Management hooks.
----------------------------------------------------------------------- 
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.SpawnOnce
import System.IO
import System.Exit

-- Other.
import qualified Data.Map as M 
import qualified XMonad.StackSet as W


-- Useful functions.
spawnAndNotify app title desc = spawn $ app ++ "; notify-send '" ++ title ++ "' '" ++ desc ++ "'" 

-- Settings.
----------------------------------------------------------------------- 
myTerminal = "urxvt"
myWorkspaces = ["term", "net", "code", "graph", "chat", "fun", "vid", "music", "other"]
myFont = "envycoder:size=10"

-- Statusbars.
-----------------------------------------------------------------------
myLeftBar = "dzen2 -w 600 -ta l -xs 1 -fn " ++ myFont
myRightBar = "conky -c ~/dotfiles/dzconkyrc | dzen2 -xs 1 -x 600 -w 1000 -ta r -fn " ++ myFont


-- Startup programs.
-----------------------------------------------------------------------
myStartupHook = do
   spawnOnce "twmnd &"

-- Management hooks.
----------------------------------------------------------------------- 
myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "net-minecraft-LauncherFrame" --> doShift "fun"
    , className =? "net-minecraft-LauncherFrame" --> doFloat
    , className =? "irssi" --> doShift "chat"
    ]

-- Log hook settings..
-----------------------------------------------------------------------
myLogHook proc = dynamicLogWithPP $ defaultPP
    { ppOutput = hPutStrLn proc
    , ppTitle = dzenColor "green" "" . shorten 50
    , ppCurrent = dzenColor "yellow" ""
    , ppUrgent = dzenColor "orange" ""
    , ppLayout = myLayout
    }

xbmPath = "/usr/share/icons/stlarch_icons/"

dzenIcon path = "^i(" ++ xbmPath ++ path ++ ")"

myLayout n 
    | n == "Full" = dzenIcon "monocle.xbm"
    | n == "Tall" = dzenIcon "tile.xbm"
    | n == "Mirror Tall" = dzenIcon "bstack.xbm" 
    | otherwise = n

-- Key Bindings.
-----------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $ 
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm .|. shiftMask, xK_KP_Enter), spawn $ XMonad.terminal conf)
    , ((modm,               xK_p     ), spawn "dmenu_run")
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")
    , ((modm .|. shiftMask, xK_c     ), kill)
    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm,               xK_n     ), refresh)
    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )
    , ((modm,               xK_Return), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
    , ((modm,               xK_h     ), sendMessage Shrink)
    , ((modm,               xK_l     ), sendMessage Expand)
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- Exit xmonad.
    , ((modm              , xK_q     ), spawnAndNotify "xmonad --recompile; xmonad --restart" "Xmonad" "Recompiled.")  -- Restart xmonad
    
    -- Applications.
    , ((modm              , xK_v     ), spawn "gvim")             -- v for Vim.
    , ((modm .|. shiftMask, xK_v     ), spawn "urxvt -e vim")     -- V for Vim in console.
    , ((modm              , xK_b     ), spawn "dwb")          -- b for Browser(Chromium).
    , ((modm .|. shiftMask, xK_b     ), spawn "chromium")         -- B for Browser(Firefox).
    , ((modm              , xK_f     ), spawn "urxvt -e ranger")          -- f for Files. 
    , ((modm .|. shiftMask, xK_f     ), spawn "pcmanfm")           -- F for Files (Thunar)
    , ((modm              , xK_c     ), spawn "urxvt -e irssi")
    , ((modm .|. shiftMask, xK_m     ), spawn "urxvt -e mutt")


    -- Media Bar
    , ((0                 , 0x1008ff11), spawn "amixer set Master 5%-")  -- Voldown
    , ((0                 , 0x1008ff13), spawn "amixer set Master 5%+")  -- Volup
    , ((0                 , 0x1008ff12), spawn "amixer set Master toggle")  -- Volmute
   ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
 
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- Main.
-----------------------------------------------------------------------
main = do
    dzenleftbar <- spawnPipe myLeftBar
    dzenrightbar <- spawnPipe myRightBar 
    xmonad $ defaultConfig{
        manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = myLogHook dzenleftbar
        , terminal = myTerminal
        , borderWidth = 1
        , modMask = mod4Mask
        , workspaces = myWorkspaces
        , keys = myKeys
        , handleEventHook = fullscreenEventHook
        , startupHook = myStartupHook
        }

