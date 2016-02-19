module Main where

import qualified Data.ByteString as BS
import System.Environment
import Text.Printf
import Types
import qualified Story as Story
import qualified Zstring as Zstring
 
main = do 
   {
       path <- getExecutablePath;
       progName <- getProgName;
       bytes <- BS.readFile (take (length path - length progName) path ++ "minizork.z3");
       let story = Story.load_Story bytes
           zstringAddress = ZstringAddress 0xb106
           text = Zstring.read_Story story zstringAddress in
       printf "%s\n" text  
   } 