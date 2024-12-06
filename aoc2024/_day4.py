import itertools
from aocd import lines

# lines = ['MMMSXXMASM','MSAMXMSMSA','AMXSXMAAMM','MSAMASMSMX','XMASAMXAMM','XXAMMXXAMA','SMSMSASXSS','SAXAMASAAA','MAMMMXMMMM','MXMXAXMASX']
lines = [line + '.' for line in lines]
lines.append('.' * len(lines[0]))

part1 = 0
search = 'XMAS'

for y, x in itertools.product(range(len(lines) - 1), range(len(lines[0]) - 1)):
    # print('-', y, x, lines[y][x])
    if lines[y][x] != search[0]:
        continue
    for dx, dy in itertools.product(range(-1, 2), repeat=2):
        # print()
        for k in range(1, len(search)):
            # print(y+dy*k,x+dx*k, k, search[k], lines[y+dy*k][x+dx*k])
            if lines[y + dy * k][x + dx * k] != search[k]:
                break
        else:
            # print('FOUND', y, x, dy, dx)
            part1 += 1

print(part1)

part2 = 0
search = 'MAS'

for j, i in itertools.product(range(len(lines) - 1), range(len(lines[0]) - 1)):
    if lines[j][i] != search[0]:
        continue
    for dy, dx in ((1, -1), (-1, 1)):
        for k in range(1, len(search)):
            if lines[j + dy * k][i + dx * k] != search[k]:
                break
        else:
            for j2, i2, dy2, dx2 in ((j + dy * 2, i, -dy, dx), (j, i + dx * 2, dy, -dx)):
                for k in range(0, len(search)):
                    if lines[j2 + dy2 * k][i2 + dx2 * k] != search[k]:
                        break
                else:
                    part2 += 1

print(part2)
