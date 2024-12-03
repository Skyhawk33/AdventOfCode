module Day3 (solve, path) where

import Text.Regex.TDFA

path :: String
path = "day3.txt"

solve :: String -> String
solve input =
  let muls = getAllTextMatches (input =~ "mul\\([0-9]+,[0-9]+\\)")
      part1 = sum $ map mul muls
      commands = getAllTextMatches (input =~ "mul\\([0-9]+,[0-9]+\\)|do\\(\\)|don't\\(\\)")
      part2 = exec 1 commands
   in show part1 ++ "\n" ++ show part2

mul :: String -> Integer
mul text = product . map read . getAllTextMatches $ text =~ "[0-9]+"

exec :: Integer -> [String] -> Integer
exec _ [] = 0
exec m ("do()" : xs) = exec 1 xs
exec m ("don't()" : xs) = exec 0 xs
exec m (x : xs) = m * (mul x) + exec m xs