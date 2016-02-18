module Story where

import Data.Bits
import qualified Data.ByteString as BS
import Types
import Utility
import qualified ImmutableBytes as IB

data Story = Story IB.ImmutableBytes BS.ByteString

read_Byte :: Story -> ByteAddress -> Int
read_Byte story address =
   let Story dynamicMemory staticMemory = story
       dynamicSize = IB.size dynamicMemory
   in
      if is_In_Range address dynamicSize then
         IB.read_Byte dynamicMemory address
      else
         let staticAddress = decrement_ByteAddress_By address dynamicSize
         in dereference_ByteString staticMemory staticAddress

write_Byte :: Story -> ByteAddress -> Int -> Story
write_Byte story address value =
   let Story dynamicMemory staticMemory = story
   in Story (IB.write_Byte dynamicMemory address value) staticMemory

read_Word :: Story -> WordAddress -> Int
read_Word story address =
   let high = read_Byte story (address_Of_High_Byte address)
       low = read_Byte story (address_Of_Low_Byte address)
   in high * 256 + low

write_Word :: Story -> WordAddress -> Int -> Story
write_Word story address value =
   let high = (value `shiftR` 8) .&. 0xFF
       low = value .&. 0xFF
       story = write_Byte story (address_Of_High_Byte address) high
   in write_Byte story (address_Of_Low_Byte address) low

header_size = 64
static_Memory_Base_Offset = WordAddress 14

abbreviations_Table_Base :: Story -> AbbreviationTableBase
abbreviations_Table_Base story =
   let abbreviationsTableBaseOffset = WordAddress 24
   in AbbreviationTableBase (read_Word story abbreviationsTableBaseOffset)
   
load_Story :: BS.ByteString -> Story
load_Story bytes =
   let len = BS.length bytes
   in
      if len < header_size then
         error "Specified file is not a valid story file"
      else
         let high = dereference_ByteString bytes (address_Of_High_Byte static_Memory_Base_Offset)
             low = dereference_ByteString bytes (address_Of_Low_Byte static_Memory_Base_Offset)
             dynamicLength = high * 256 + low
         in
            if dynamicLength > len then
               error "Specified file is not a valid story file"
            else
               let (dynamic, static) = BS.splitAt dynamicLength bytes
               in Story (IB.make_ImmutableBytes dynamic) static
   
