module Main where

import qualified Data.ByteString.Char8 as BS (pack)
import Text.Printf
import Types
import Utility
import ImmutableBytes


main :: IO()
main = 
  let addr1 = ByteAddress 1 in
  let bytes_a = make_ImmutableBytes (BS.pack "Hello world") in
  let bytes_b = ImmutableBytes.write_Byte bytes_a addr1 65 in
  let b_a = ImmutableBytes.read_Byte bytes_a addr1 in
  let b_b = ImmutableBytes.read_Byte bytes_b addr1 in
  printf "%d %d\n" b_a b_b
  