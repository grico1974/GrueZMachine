module Zstring where

import qualified Data.Char as Char (chr)
import Text.Printf
import Types
import Utility
import qualified Story as Story

data StringState = Alphabet Int |
                   Leading |
                   Abbreviation AbbreviationNumber |
                   Trailing Int
                   deriving (Eq)

alphabet0 = Alphabet 0
alphabet1 = Alphabet 1
alphabet2 = Alphabet 2
abbrev0 = Abbreviation (AbbreviationNumber 0)
abbrev32 = Abbreviation (AbbreviationNumber 32)
abbrev64 = Abbreviation (AbbreviationNumber 64)

alphabetTable :: [[Char]]
alphabetTable = [ " ?????abcdefghijklmnopqrstuvwxyz",
                  " ?????ABCDEFGHIJKLMNOPQRSTUVWXYZ",
                  " ??????\n0123456789.,!?_#'\"/\\-:()" ]                

abbreviationTableLength :: Int
abbreviationTableLength = 96

uncompress_Address :: WordZstringAddress -> ZstringAddress
uncompress_Address address =
   let WordZstringAddress addr = address
   in ZstringAddress (2 * addr)

first_AbbreviationAddress :: AbbreviationTableBase -> WordAddress
first_AbbreviationAddress address =
   let AbbreviationTableBase baseAddress = address
   in WordAddress baseAddress

abbreviation_ZstringAddress :: Story.Story -> AbbreviationNumber -> ZstringAddress
abbreviation_ZstringAddress story number =
   let AbbreviationNumber n = number
   in
      if n < 0 || n >=    abbreviationTableLength then
         error "Bad offset into abbreviation table"
      else
        let base = first_AbbreviationAddress (Story.abbreviations_Table_Base story)
            abbreviationAddress = increment_WordAddress_By base n
            compressedAddress = WordZstringAddress (Story.read_Word story abbreviationAddress)
        in uncompress_Address compressedAddress

read_Story :: Story.Story -> ZstringAddress -> String
read_Story story addr =
   let ZstringAddress address = addr
   in aux "" alphabet0 (WordAddress address) where
      aux :: String -> StringState -> WordAddress -> String
      aux acc state1 current_address =
         let zcharBitSize = size5
             word = Story.read_Word story current_address
             isEnd = fetch_Bit bit15 word
             zchar1 = Zchar (fetch_Bits bit14 size5 word)
             zchar2 = Zchar (fetch_Bits bit9 size5 word)
             zchar3 = Zchar (fetch_Bits bit4 size5 word)
             (text1, state2) = process_Zchar zchar1 state1
             (text2, state3) = process_Zchar zchar2 state2
             (text3, stateNext) = process_Zchar zchar3 state3
             newAcc = acc ++ text1 ++ text2 ++ text3
         in
            if isEnd == One then newAcc
            else aux newAcc stateNext (increment_WordAddress current_address)
         where
            process_Zchar :: Zchar -> StringState -> (String, StringState)
            process_Zchar (Zchar zchar) state = next_State zchar state where
               next_State 1 (Alphabet _) = ("", abbrev0)
               next_State 2 (Alphabet _) = ("", abbrev32)
               next_State 3 (Alphabet _) = ("", abbrev64)
               next_State 4 (Alphabet _) = ("", alphabet1)
               next_State 5 (Alphabet _) = ("", alphabet2)
               next_State 6 (Alphabet 2) = ("", Leading)
               next_State _ (Alphabet a) = ([alphabetTable !! a !! zchar], alphabet0)
               next_State _ (Abbreviation (AbbreviationNumber a)) =
                  let abbrv = AbbreviationNumber(a + zchar)
                      addr = abbreviation_ZstringAddress story abbrv
                      str = read_Story story addr
                  in (str, alphabet0)
               next_State _ Leading = ("", Trailing zchar)
               next_State _ (Trailing high) =
                  let s = [Char.chr (high * 32 + zchar)]
                  in (s, alphabet0)  
 
display_Bytes :: Story.Story -> ZstringAddress -> String
display_Bytes story address =
   let ZstringAddress addr = address
   in aux (WordAddress addr) "" where
      aux :: WordAddress -> String -> String
      aux current acc =
         let word = Story.read_Word story current
             isEnd = fetch_Bit bit15 word
             zchar1 = fetch_Bits bit14 size5 word
             zchar2 = fetch_Bits bit9 size5 word
             zchar3 = fetch_Bits bit4 size5 word
             s = printf "%x %x %x " zchar1 zchar2 zchar3
             newAcc = acc ++ s
         in
            if isEnd == One then newAcc
            else aux (increment_WordAddress current) newAcc
