module Dictionary where

import Text.Printf
import Types
import Utility
import qualified Story as Story
import qualified Zstring as Zstring

word_Separators_Base :: DictionaryBase -> ByteAddress
word_Separators_Base (DictionaryBase base) =
   ByteAddress base

word_Separators_Count :: Story.Story -> Int
word_Separators_Count story =
   (Story.read_Byte story) . word_Separators_Base . Story.dictionary_Base $ story

entry_Base :: Story.Story -> ByteAddress
entry_Base story =
   let wordSeparatorsCount = word_Separators_Count story
       wordSeparatorsBase = word_Separators_Base . Story.dictionary_Base $ story
   in increment_ByteAddress_By wordSeparatorsBase $ wordSeparatorsCount + 1

entry_Length :: Story.Story -> Int
entry_Length story =
   Story.read_Byte story $ entry_Base story   

entry_Count :: Story.Story -> Int
entry_Count story =
    let ByteAddress address = increment_ByteAddress $ entry_Base story
    in Story.read_Word story $ WordAddress address

table_Base:: Story.Story -> DictionaryTableBase
table_Base story = 
    let ByteAddress address = increment_ByteAddress_By (entry_Base story) 3
    in DictionaryTableBase address

entry_Address :: Story.Story -> DictionaryNumber -> DictionaryAddress
entry_Address story (DictionaryNumber dictionaryNumber) = 
   let DictionaryTableBase base = table_Base story
       length = entry_Length story
   in DictionaryAddress $ base + dictionaryNumber * length 

entry :: Story.Story -> DictionaryNumber -> String
entry story dictionaryNumber =
   let DictionaryAddress address = entry_Address story dictionaryNumber
   in Zstring.read_Story story $ ZstringAddress address     

display :: Story.Story -> String
display story =
   let count = entry_Count story
   in accumulate_Strings_Loop to_String 0 count where
      to_String :: Int -> String
      to_String i = printf "%s " $ entry story $ DictionaryNumber i