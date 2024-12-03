module Day1 (solve, path) where

import Data.List (sort)
import Debug.Trace

path :: String
path = "day1.txt"

solve :: String -> String
solve input =
  let (xs, ys) = unzip [(read x, read y) | (x : y : _) <- map words (lines input)]
      sortedXs = sort xs
      sortedYs = sort ys
      part1 = sum [abs (x - y) | (x, y) <- zip sortedXs sortedYs]
      part2 = similarity 0 0 sortedXs sortedYs
   -- in show sortedXs ++ "\n" ++ show sortedYs ++ "\n" ++ show part1 ++ "\n" ++ show part2
   in show part1 ++ "\n" ++ show part2

-- traceShow (show p ++ show total ++ show q ++ show counter)
similarity total counter p@(x : xs) []
  | null xs = total + x * counter
  | head xs == x = similarity (total + x * counter) counter xs []
  | otherwise = similarity (total + x * counter) 0 xs []
similarity total counter p@(x : xs) q@(y : ys)
  | y < x = similarity total counter p ys
  | y == x = similarity total (counter + 1) p ys
  | null xs = total + x * counter
  | head xs == x = similarity (total + x * counter) counter xs q
  | otherwise = similarity (total + x * counter) 0 xs q
