module Main where

import qualified Data.ByteString as BS
import System.Environment
import Text.Printf
import Types
import Utility
import qualified Story as Story

main = do {
    path <- getExecutablePath;
    progName <- getProgName;
    bytes <- BS.readFile (take (length path - length progName) path ++ "minizork.z3");
    let story = Story.load_Story bytes in
    let versionAddress = ByteAddress 0 in
    let version = Story.read_Byte story versionAddress in
    printf "Version of file is: v%d\n" version
  }
  