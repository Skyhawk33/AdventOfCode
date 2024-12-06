module Day4 (solve, path) where

import Data.List (isPrefixOf, tails, transpose)
import Debug.Trace

path :: String
path = "day4.txt"

solve :: String -> String
solve input =
  let grid = lines input
      flipped = transpose grid
      skewed = transpose [pad i (length grid - i) line | (i, line) <- zip [0 ..] grid]
      skewed2 = transpose [pad (length grid - i) 0 line | (i, line) <- zip [1 ..] grid]
      crosses = [ top : bottom : (take 3 middleRow)
                  | (r1, r2, r3) <- zip3 skewed (drop 2 skewed) (drop 4 skewed),
                    (top, middleRow, bottom) <- zip3 r1 (tails r2) (drop 2 r3) ]
      part1 = sum $ map (findAll $ grid ++ flipped ++ skewed ++ skewed2) ["SAMX", "XMAS"]
      part2 = length $ filter (`elem` ["MSMAS", "SMMAS", "MSSAM", "SMSAM"]) crosses
   in show part1 ++ "\n" ++ show part2

pad :: Int -> Int -> String -> String
pad left right string = replicate left '.' ++ string ++ replicate right '.'

findAll :: [String] -> String -> Int
findAll rows search = sum $ map (\x -> length $ filter (isPrefixOf search) (tails x)) rows
