module Lazr.Bar (
    universalLogHook,
    makePipe
) where

import System.IO
import System.Posix
import System.Posix.IO
import Data.Maybe
import Control.Monad                        (void)
import XMonad
import XMonad.Hooks.DynamicLog

makePipe :: IO Handle
makePipe = do
    name <- getEnv "PANEL_FIFO"
    trace $ "xmonad: Panel fifo environment var: " ++ show name
    fd <- openFd (fromMaybe "/home/lazr/tmp/panel-fifo" name) WriteOnly Nothing defaultFileFlags
    fdToHandle fd

pipeOutput :: Handle -> String -> IO ()
pipeOutput handle output = do
    trace $ "xmonad: Pipe output: " ++ output
    hPutStrLn handle output

universalLogHook handle =
    dynamicLogWithPP $ def
        { ppCurrent = lemonbarColor "#0aa"
        , ppHidden  = lemonbarColor "#444"
        , ppUrgent  = lemonbarColor "#aa0"
        , ppVisible  = lemonbarColor "#aaa"
        -- , ppOutput  = \s -> void $ fdWrite fd (s ++ "\n")
        , ppOutput  = pipeOutput handle
        }

lemonbarColor color string = "%{F" ++ color ++ "}" ++ string ++ "%{F-}"
