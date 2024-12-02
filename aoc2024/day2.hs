import Data.Text as Text (Text, lines, unpack)
import Data.Text.IO as Text (readFile)
import Debug.Trace (traceShow)

solve :: [String] -> String
solve lines =
  let part1 = sum [1 | line <- lines, isSafe 0 (map read (words line))]
      part2 = sum [1 | line <- lines, isSafe 1 (map read (words line))]
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

main :: IO ()
main = do
  textLines <- fmap Text.lines (Text.readFile "data/day2.txt")
  let stringLines = map unpack textLines
  putStrLn . solve $ stringLines