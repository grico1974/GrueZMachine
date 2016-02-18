module Main where

import Data.Bits
import Types
import Utility
import Text.Printf

word :: Int
word = 0xBEEF

fetch_Bits_Original :: Int -> Int -> Int -> Int
fetch_Bits_Original high length word =
   let mask = complement ((-1) `shiftL` length) in
   (word `shiftR` ( high - length + 1)) .&. mask

main :: IO()
main = 
  printf "First try: %0x \n" ((word `shiftR` 12) .&. (complement ((-1) `shiftL` 15))) >>
  printf "fetch_Bits_Original: %0x \n" (fetch_Bits_Original 15 4 word) >>
  printf "fetch_Bits: %0x \n" (fetch_Bits bit15 size4 word)