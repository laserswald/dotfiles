module Lazr.Colors (rstrip, getColor)
where

import System.Process
import Data.Char (isSpace)

rstrip = reverse . dropWhile isSpace . reverse

getColor :: String -> IO String
getColor color = readProcess "/home/ben/bin/tcolor" [color] []

