module Main where

import qualified Data.ByteString as BS
import System.Environment
import Text.Printf
import Types
import qualified Story as Story
import qualified Dictionary as Dictionary 

main :: IO ()
main = do
       bytes <- open_Story_File "minizork.z3"
       let story = Story.load_Story bytes
       printf "%s\n" $ Dictionary.display story

open_Story_File :: FilePath -> IO BS.ByteString
open_Story_File fileName = do
                  path <- getExecutablePath
                  progName <- getProgName
                  BS.readFile $ take (length path - length progName) path ++ fileName
