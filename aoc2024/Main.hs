module Main where

import Day5 (solve, path)

main :: IO ()
main = do
  input <- readFile $ "aoc2024/data/" ++ path
  putStrLn . solve $ input
