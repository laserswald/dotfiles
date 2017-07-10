module Lazr.Colors (rstrip, getColor)
where

import System.Process
import Data.Char (isSpace)

rstrip :: String -> String
rstrip = reverse . dropWhile isSpace . reverse

getColor :: String -> IO String
getColor color = do
    ret <- readProcess "/home/ben/bin/tcolor" [color] []
    return $ rstrip ret

