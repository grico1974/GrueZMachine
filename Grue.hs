module Main where

import qualified Data.ByteString as BS
import System.Environment
import Text.Printf
import Types
import qualified Story as Story
import qualified Dictionary as Dictionary 

main = do
       path <- getExecutablePath
       progName <- getProgName
       let storyPath = take (length path - length progName) path ++ "minizork.z3"
       bytes <- BS.readFile storyPath
       let story = Story.load_Story bytes
       printf "%s\n" $ Dictionary.display story