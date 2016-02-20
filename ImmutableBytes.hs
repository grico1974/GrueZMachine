module ImmutableBytes where

import qualified Data.IntMap as IntMap
import qualified Data.ByteString as BS
import Data.Word (Word8)
import Types
import Utility

data ImmutableBytes = ImmutableBytes BS.ByteString (IntMap.IntMap Word8) 

make_ImmutableBytes :: BS.ByteString -> ImmutableBytes
make_ImmutableBytes bytes =
   ImmutableBytes  bytes IntMap.empty
   
size :: ImmutableBytes -> Int
size (ImmutableBytes originalBytes _) = BS.length originalBytes

read_Byte :: ImmutableBytes -> ByteAddress -> Int
read_Byte bytes address =
   let ImmutableBytes originalBytes edits = bytes
   in
      if is_Out_Of_Range address $ BS.length originalBytes then 
         error "address is out of range"
      else
         let ByteAddress addr = address
             word = if IntMap.member addr edits then
                       edits IntMap.! addr 
                    else
                       originalBytes `BS.index` addr
         in fromIntegral word

write_Byte :: ImmutableBytes -> ByteAddress -> Int -> ImmutableBytes
write_Byte bytes address value =
   let ImmutableBytes originalBytes edits = bytes
   in
      if is_Out_Of_Range address $ BS.length originalBytes then 
         error "address is out of range"
      else
         let ByteAddress addr = address
             word = fromIntegral value :: Word8
         in ImmutableBytes originalBytes $ IntMap.insert addr word edits

original :: ImmutableBytes -> ImmutableBytes
original (ImmutableBytes originalBytes _) =
   ImmutableBytes originalBytes IntMap.empty

