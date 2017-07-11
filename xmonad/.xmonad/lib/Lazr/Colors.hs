module Lazr.Colors (
    rstrip,
    getColor
) where

import System.Process
import Data.Char (isSpace)

rstrip :: String -> String
rstrip = reverse . dropWhile isSpace . reverse

getColor :: String -> IO String
getColor colorname = do
    homedir <- getEnv "HOME"
    let tc = homedir ++ "/bin/tcolor"
    out <- runProcessWithInput tc [colorname] []
    return $ rstrip out
