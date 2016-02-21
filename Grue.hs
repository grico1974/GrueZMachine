module Main where

import qualified Data.ByteString as BS
import System.Environment
import Text.Printf
import Types
import Utility
import qualified Story as Story
import qualified Zstring as Zstring

main = do
       path <- getExecutablePath
       progName <- getProgName
       let storyPath = take (length path - length progName) path ++ "minizork.z3"
       bytes <- BS.readFile storyPath
       let story = Story.load_Story bytes
           zstring1 = Zstring.abbreviation_ZstringAddress story (AbbreviationNumber 0)
           text1 = Zstring.display_Bytes story zstring1
           zstring2 = Zstring.abbreviation_ZstringAddress story (AbbreviationNumber 4)
           text2 = Zstring.display_Bytes story zstring2
       printf "%s\n" text1
       printf "%s\n" text2  