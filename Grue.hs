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
           zstringAddress = ZstringAddress 0xb106
           text = Zstring.read_Story story zstringAddress in
       printf "%s\n" text
   }   