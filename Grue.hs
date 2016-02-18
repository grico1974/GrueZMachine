module Main where

import qualified Data.ByteString as BS
import Text.Printf
import Types
import Utility
import qualified Story as Story

main = do {
    bytes <- (BS.readFile "minizork.z3");
    let story = Story.load_Story bytes in
    let versionAddress = ByteAddress 0 in
    let version = Story.read_Byte story versionAddress in
    printf "Version of file is: v%d\n" version
  }
  