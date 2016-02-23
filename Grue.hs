module Main where

import qualified Data.ByteString as BS
import System.Environment
import Text.Printf
import Types
import qualified Story as Story
import qualified Zstring as Zstring
 
main = do
       bytes <- open_Story_File "minizork.z3"
       let story = Story.load_Story bytes
           text = Zstring.read_Story story $ ZstringAddress 0xb106
       printf "%s\n" text

--Platform independent
--Relative paths are not working as expected in OS X
open_Story_File :: FilePath -> IO BS.ByteString
open_Story_File fileName = 
   do path <- getExecutablePath
      progName <- getProgName
      BS.readFile $ take (length path - length progName) path ++ fileName