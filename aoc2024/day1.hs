import Data.List (sort)
import Data.Text as Text (Text, lines, unpack)
import Data.Text.IO as Text (readFile)
import Debug.Trace

solve :: [String] -> String
solve lines =
  let (xs, ys) = unzip [(read x, read y) | (x : y : _) <- map words lines]
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

main :: IO ()
main = do
  textLines <- fmap Text.lines (Text.readFile "data/day1.txt")
  let stringLines = map unpack textLines
  putStrLn . solve $ stringLines