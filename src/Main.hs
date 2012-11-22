{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
module Main (main) where

import Data.Char
import Data.UnixTime
import Foreign.C.Types
import System.Environment
import qualified Data.ByteString.Char8      as BS

main :: IO ()
main = do
  args <- getArgs
  let (r :: Integer) =
        case args of
          (x:_) | all isDigit x -> read x
          _ -> 10
  now <- getUnixTime
  let radius = r * 365 * 24 * 60 * 60
      mint = addUnixDiffTime now $ secondsToUnixDiffTime ((-1) * radius)
      maxt = addUnixDiffTime now $ secondsToUnixDiffTime radius
  interact (unlines . map (unwords . map (replaceIfTime mint maxt). words) . lines)

replaceIfTime :: UnixTime -> UnixTime -> String -> String
replaceIfTime mint maxt xs | all isDigit xs =
  case (fromEpochTime . CTime $ read xs, fromEpochTime . CTime . fromIntegral $ read xs `div` (1000 :: Integer)) of
    (t, _) | inRange t -> format t
    (_, t) | inRange t -> format t
    _ -> xs
  where
    inRange t = mint <= t && t <= maxt
    format t = "{" ++ xs ++ "|" ++ (BS.unpack $ formatUnixTimeGMT "%Y-%m-%d %H:%M:%S" t) ++ "}"
replaceIfTime _ _ xs = xs