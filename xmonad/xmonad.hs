-- laserdude's xmonad.hs file.

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import System.Exit

import qualified Data.Map as M 
import qualified XMonad.StackSet as W

-- Management hooks. 
myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "net-minecraft-LauncherFrame" --> doShift "fun"
    , className =? "net-minecraft-LauncherFrame" --> doFloat
    ]


main = do
    dzenleftbar <- spawnPipe myBar
    dzenrightbar <- spawnPipe "conky -c ~/dotfiles/dzconkyrc | dzen2 -xs 1 -x 800 -w 800 -ta r"
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
        }

myBar = "dzen2 -w 800 -ta 'l' -xs 1"
myTerminal = "urxvt"
myWorkspaces = ["!term", "@net", "#code", "$graph", "%chat", "^fun", "&vid", "*music", "(other"]

myLogHook proc = dynamicLogWithPP $ defaultPP
    { ppOutput = hPutStrLn proc
    , ppTitle = dzenColor "green" "" . shorten 50
    , ppCurrent = dzenColor "yellow" ""
    , ppUrgent = dzenColor "orange" ""
    }



-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $ 
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
 
    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")
 
    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")
 
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
 
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
 
    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
 
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
 
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
 
    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
 
    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
 
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
 
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- Exit xmonad.
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")  -- Restart xmonad
    
    -- Custom keybindings.
    , ((modm              , xK_v     ), spawn "gvim")             -- v for Vim.
    , ((modm .|. shiftMask, xK_v     ), spawn "urxvt -e vim")     -- V for Vim in console.
    , ((modm              , xK_b     ), spawn "firefox")          -- b for Browser(Chromium).
    , ((modm .|. shiftMask, xK_b     ), spawn "chromium")         -- B for Browser(Firefox).
    , ((modm              , xK_f     ), spawn "pcmanfm")          -- f for Files. 
    , ((modm .|. shiftMask, xK_f     ), spawn "thunar")           -- F for Files (Thunar)
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



