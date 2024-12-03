module Day2 (solve, path) where

import Debug.Trace (traceShow)

path :: String
path = "day2.txt"

solve :: String -> String
solve input =
  let part1 = sum [1 | line <- lines input, isSafe 0 (map read (words line))]
      part2 = sum [1 | line <- lines input, isSafe 1 (map read (words line))]
   in show part1 ++ "\n" ++ show part2

isBetween x lower upper = lower < x && x < upper

isSafe (-1) _ = False
isSafe _ [] = True
isSafe _ [x] = True
isSafe mis p@(x : xs) =
  let a = isIncreasing mis p
          || isDecreasing mis p
          || isSafe (mis - 1) xs
   in a -- traceShow a a

isIncreasing (-1) _ = False
isIncreasing _ [] = True
isIncreasing _ [a] = True
isIncreasing mis x@(x0 : x1 : xs) =
  -- traceShow ("^" ++ show x ++ show mis)
  (x0 < x1 && isBetween (x1 - x0) 0 4 && isIncreasing mis (x1 : xs))
    || isIncreasing (mis - 1) (x0 : xs)

isDecreasing (-1) _ = False
isDecreasing _ [] = True
isDecreasing _ [a] = True
isDecreasing mis x@(x0 : x1 : xs) =
  -- traceShow ("v" ++ show x ++ show mis)
  (x0 > x1 && isBetween (x0 - x1) 0 4 && isDecreasing mis (x1 : xs))
    || isDecreasing (mis - 1) (x0 : xs)
