module Zstring where

import Text.Printf
import Types
import Utility
import qualified Story as Story

abbreviationTableLength :: Int
abbreviationTableLength = 96

alphabetTable :: [Char]
alphabetTable = "_?????abcdefghijklmnopqrstuvwxyz"

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

display_Bytes :: Story.Story -> ZstringAddress -> String
display_Bytes story address =
   let ZstringAddress addr = address
   in aux (WordAddress addr) "" where
      aux current acc =
         let word = Story.read_Word story current
             isEnd = fetch_Bit bit15 word
             zchar1 = fetch_Bits bit14 size5 word
             zchar2 = fetch_Bits bit9 size5 word
             zchar3 = fetch_Bits bit4 size5 word
             s = printf "%x %c %x %c %x %c "
                        zchar1 (alphabetTable !! zchar1)
                        zchar2 (alphabetTable !! zchar2)
                        zchar3 (alphabetTable !! zchar3)
             newAcc = acc ++ s
         in
            if isEnd == One then newAcc
            else aux (increment_WordAddress current) newAcc


      
   