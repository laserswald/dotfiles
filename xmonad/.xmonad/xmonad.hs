-- xmonad.hs
-- Xmonad configuration file
-- (c) 2017 Laserswald

import System.Exit
import System.IO
import System.Environment
import System.Directory
import System.Posix.Files
import System.Posix.IO

import Control.Monad (void)

import XMonad
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.Tabbed
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Prompt
import XMonad.Prompt.Shell

-- Other.
import qualified Data.Map as M
import qualified XMonad.StackSet as W

-- Personal configs
import Lazr.Colors
import Lazr.Bar
import Lazr.Settings

-- Useful functions.
-----------------------------------------------------------------------
spawnAndNotify app title desc = spawn $ app ++ "; notify-send '" ++ title ++ "' '" ++ desc ++ "'"

-- Settings.
-----------------------------------------------------------------------
myWorkspaces = ["!", "@", "#", "$", "%", "^", "&", "*", "("]
myFont = "terminesspowerline:size=10"

-- Statusbars.
-----------------------------------------------------------------------
--myLeftBar = "~/dotfiles/dzen/left.sh"
--myRightBar = "~/dotfiles/dzen/right.sh"

-- Management hooks.
-----------------------------------------------------------------------
myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , className =? "Vncviewer" --> doFloat
    , className =? "net-minecraft-LauncherFrame" --> doShift "fun"
    , className =? "net-minecraft-LauncherFrame" --> doFloat
    , className =? "irssi" --> doShift "chat"
    ]


dmenuCustom = "dmenu_run -i -p ':' -b -fn terminesspowerline:size=10"

-- Key Bindings.
-----------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)
    , ((modm,             xK_KP_Enter), spawn $ XMonad.terminal conf)
    , ((modm,               xK_semicolon ), spawn dmenuCustom)
    , ((modm .|. shiftMask, xK_semicolon ), spawn dmenuCustom)
    , ((modm .|. shiftMask, xK_c     ), kill)
    , ((modm,               xK_space ), sendMessage NextLayout)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm,               xK_n     ), nextWS)
    , ((modm,               xK_p     ), prevWS)
    , ((modm .|. shiftMask, xK_n     ), shiftToNext)
    , ((modm .|. shiftMask, xK_p     ), shiftToPrev)
    , ((modm,               xK_Tab   ), windows W.focusDown)
    , ((modm,               xK_j     ), windows W.focusDown)
    , ((modm,               xK_k     ), windows W.focusUp  )
    , ((modm,               xK_m     ), windows W.focusMaster  )
    --, ((modm,               xK_Return), windows W.swapMaster)
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
    , ((modm              , xK_b     ), spawn "firefox")
    , ((modm .|. shiftMask, xK_b     ), spawn "dwb")
    , ((modm              , xK_f     ), spawn "urxvt -e ranger")
    , ((modm .|. shiftMask, xK_f     ), spawn "pcmanfm")
    , ((modm              , xK_c     ), spawn "urxvt -e 'tmux new-session -A -s chat'")
    , ((modm .|. shiftMask, xK_m     ), spawn "urxvt -e 'tmux new-session -A -s mail'")

    -- Prompts.
    --TODO: Looks like we need a better XPconfig
    , ((modm .|. shiftMask, xK_slash), shellPrompt defaultXPConfig)




    -- Media Bar
    , ((0                 , 0x1008ff11), spawn "amixer set Master 5%-")  -- Voldown
    , ((0                 , 0x1008ff13), spawn "amixer set Master 5%+")  -- Volup
    , ((0                 , 0x1008ff12), spawn "amixer set Master toggle")  -- Volmute
   ]
    ++

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
main :: IO ()
main = do
    fifo         <- makePipe
    trace $ "Fifo is " ++ show fifo
    focusedColor <- getColor "green"
    normalColor  <- getColor "brblack"
    myTerminal <- getTerminal
    xmonad $ ewmh defaultConfig
        { borderWidth        = 1
        , focusedBorderColor = focusedColor
        , handleEventHook    = fullscreenEventHook <+> docksEventHook <+> handleEventHook def
        , keys               = myKeys
        , layoutHook         = avoidStruts $ (layoutHook defaultConfig ||| simpleTabbed)
        , logHook            = universalLogHook fifo
        , manageHook         = manageDocks <+> myManageHook <+> manageHook defaultConfig
        , modMask            = mod4Mask
        , normalBorderColor  = normalColor
        , startupHook        = docksStartupHook
        , terminal           = myTerminal
        , workspaces         = myWorkspaces
        }

