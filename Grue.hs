module Main where

import qualified Data.ByteString as BS
import System.Environment
import Text.Printf
import System.Environment
import Types
import Utility
import qualified Story as Story

<<<<<<< HEAD
main :: IO ()
main = 
   do bytes <- open_Story_File "minizork.z3"
      let story = Story.load_Story bytes
      let versionAddress = ByteAddress 0
      printf "Version of file is: v%d\n" $ Story.read_Byte story versionAddress
  
--Platform independent
--Relative paths are not working as expected in OS X
open_Story_File :: FilePath -> IO BS.ByteString
open_Story_File fileName = 
   do path <- getExecutablePath
      progName <- getProgName
      BS.readFile $ take (length path - length progName) path ++ fileName
=======
main = do {
    path <- getExecutablePath;
    progName <- getProgName;
    bytes <- BS.readFile (take (length path - length progName) path ++ "minizork.z3");
    let story = Story.load_Story bytes in
    let versionAddress = ByteAddress 0 in
    let version = Story.read_Byte story versionAddress in
    printf "Version of file is: v%d\n" version
  }
>>>>>>> origin/Part3
  