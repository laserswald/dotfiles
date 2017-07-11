module Lazr.Colors (
    getColor
) where

import Control.Monad
import Data.Char
import System.Environment
import System.IO
import XMonad.Util.Run

rstrip = reverse . dropWhile isSpace . reverse

getColor :: String -> IO String
getColor colorname = do
    homedir <- getEnv "HOME"
    let tc = homedir ++ "/bin/tcolor"
    out <- runProcessWithInput tc [colorname] []
    return $ rstrip out
