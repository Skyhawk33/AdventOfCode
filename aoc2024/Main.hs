module Main where

import Day3 (solve, path)

main :: IO ()
main = do
  input <- readFile $ "aoc2024/data/" ++ path
  putStrLn . solve $ input