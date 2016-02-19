module Main where

import qualified Data.ByteString as BS
import Text.Printf
import Types
import Utility
import qualified Story as Story
import qualified Zstring as Zstring

main = do 
   {
       bytes <- (BS.readFile "./minizork.z3");
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