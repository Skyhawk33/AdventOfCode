import itertools

from aocd import lines

# lines = """....#.....
# .........#
# ..........
# ..#.......
# .......#..
# ..........
# .#..^.....
# ........#.
# #.........
# ......#...""".splitlines()

grid = [list(line + '-') for line in lines]
backup = [list(line + '-') for line in lines]
grid += ['-'*len(grid[0])]
turn = {
    (0, -1) : (1, 0),
    (1, 0) : (0, 1),
    (0, 1) : (-1, 0),
    (-1, 0) : (0, -1),
}
start_x, start_y = 0, 0
for i, line in enumerate(lines):
    if '^' in line:
        start_x, start_y = line.index('^'), i
        break
start_dir = (0, -1)


def move(grid, start_x, start_y, start_dir):
    x, y = start_x, start_y
    dir = start_dir
    dx, dy = dir
    states = set()
    visited = 0
    while 0 <= x < len(grid[0])-1 and 0 <= y < len(grid)-1:
        if (x, y, dx, dy) in states:
            return -1, (x,y,dx,dy)
        states.add((x,y,dx,dy))
        if grid[y][x] != 'X':
            grid[y][x] = 'X'
            visited += 1
        while grid[y+dy][x+dx] is '#':
            dir = turn[dir]
            dx, dy = dir
        x, y = x+dx, y+dy
    return visited, None


print(move(grid, start_x, start_y, start_dir))

part2 = 0
for y, x in itertools.product(range(len(grid)-1), range(len(grid[0])-1)):
    if grid[y][x] not in ('#', '^', '-'):
        # print(grid[y][x], x, y)
        # grid = [list(line + '-') for line in lines] + ['-'*len(grid[0])]
        grid[y][x] = '#'
        distance, looped = move(grid, start_x, start_y, start_dir)
        if distance < 0:
            # grid[y][x] = 'O'
            # grid[looped[1]][looped[0]] = '?'
            # for row in grid:
            #     print(''.join(row))
            # print(distance, looped)
            part2 += 1
            # print(x, y)
        grid[y][x] = '.'

print(part2) # wrong 1465
