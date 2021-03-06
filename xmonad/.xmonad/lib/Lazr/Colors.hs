module Lazr.Colors (
    rstrip,
    getColor
) where

import System.Environment
import System.IO
import System.Process
import Data.Char (isSpace)
import Control.Monad
import XMonad.Util.Run

rstrip :: String -> String
rstrip = reverse . dropWhile isSpace . reverse

getColor :: String -> IO String
getColor colorname = do
    homedir <- getEnv "HOME"
    let tc = homedir ++ "/bin/tcolor"
    out <- runProcessWithInput tc [colorname] []
    return $ rstrip out
