module Lazr.Settings (
    getTerminal
) where

import System.Environment

getTerminal = do getEnv "TERMINAL"

