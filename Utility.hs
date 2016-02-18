module Utility where

import Data.Bits
import qualified Data.ByteString as BS
import Types

size1 = BitSize 1
size2 = BitSize 2
size3 = BitSize 3
size4 = BitSize 4
size5 = BitSize 5
size6 = BitSize 6
size7 = BitSize 7

bit0 = BitNumber 0
bit1 = BitNumber 1
bit2 = BitNumber 2
bit3 = BitNumber 3
bit4 = BitNumber 4
bit5 = BitNumber 5
bit6 = BitNumber 6
bit7 = BitNumber 7
bit8 = BitNumber 8
bit9 = BitNumber 9
bit10 = BitNumber 10
bit11 = BitNumber 11
bit12 = BitNumber 12
bit13 = BitNumber 13
bit14 = BitNumber 14
bit15 = BitNumber 15

fetch_Bit :: BitNumber -> Int -> Bit
fetch_Bit bit word =
   if (let BitNumber n = bit
       in ((1 `shiftL` n) .&. word) `shiftR` n) == 1
   then One else Zero
   
clear_Bit :: BitNumber -> Int -> Int
clear_Bit bit word =
   let BitNumber n = bit
   in word `clearBit` n

set_Bit :: BitNumber -> Int -> Int
set_Bit bit word =
   let BitNumber n = bit 
   in word `setBit` n
   
set_Bit_To :: BitNumber -> Int -> Bit -> Int
set_Bit_To bit word value =  
   if value == Zero then clear_Bit bit word 
   else set_Bit bit word 

fetch_Bits :: BitNumber -> BitSize -> Int -> Int
fetch_Bits highBit bitLength word = 
   let BitNumber high = highBit
       BitSize length = bitLength
       mask = complement ((-1) `shiftL` length)
   in (word `shiftR` ( high - length + 1)) .&. mask

is_In_Range :: ByteAddress -> Int -> Bool
is_In_Range address size =
   let (ByteAddress addr) = address
   in 0 <= addr && addr < size

is_Out_Of_Range :: ByteAddress -> Int -> Bool
is_Out_Of_Range address size = not (is_In_Range address size)

increment_ByteAddress_By :: ByteAddress -> Int -> ByteAddress
increment_ByteAddress_By address offset =
   let ByteAddress addr = address
   in ByteAddress (addr + offset)

decrement_ByteAddress_By :: ByteAddress -> Int -> ByteAddress
decrement_ByteAddress_By address offset =
   increment_ByteAddress_By address (-offset)

dereference_ByteString :: BS.ByteString -> ByteAddress -> Int
dereference_ByteString bytes address =
   if is_Out_Of_Range address (BS.length bytes) then
      error "address out of range"
   else
      let ByteAddress addr = address
      in fromIntegral (bytes `BS.index` addr)

address_Of_High_Byte :: WordAddress -> ByteAddress
address_Of_High_Byte address =
   let WordAddress addr = address
   in ByteAddress addr

address_Of_Low_Byte :: WordAddress -> ByteAddress
address_Of_Low_Byte address =
   let WordAddress addr = address
   in ByteAddress (addr + 1)

wordSize :: Int
wordSize = 2

increment_WordAddress_By :: WordAddress -> Int -> WordAddress
increment_WordAddress_By address offset =
   let WordAddress addr = address
   in WordAddress (addr + offset * wordSize)

increment_WordAddress :: WordAddress -> WordAddress
increment_WordAddress address =
   increment_WordAddress_By address 1