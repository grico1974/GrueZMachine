module Main where

import qualified Data.ByteString as BS
import System.Environment
import Text.Printf
import Types
import Utility
import qualified Story as Story
import qualified Zstring as Zstring

main = do 
   {
       path <- getExecutablePath;
       progName <- getProgName;
       bytes <- BS.readFile (take (length path - length progName) path ++ "minizork.z3");
       let story = Story.load_Story bytes
       in do
       {
           let zstring = Zstring.abbreviation_ZstringAddress story (AbbreviationNumber 0)
               text = Zstring.display_Bytes story zstring
           in printf "%s\n" text;
           let zstring = Zstring.abbreviation_ZstringAddress story (AbbreviationNumber 4)
               text = Zstring.display_Bytes story zstring
           in printf "%s\n" text 
        }      
   }   