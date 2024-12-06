from aocd import data


def sort_pages(ordering, rules):
    while True:
        seen = set()
        for i in range(len(ordering)):
            num = ordering[i]
            if num in rules and seen.intersection(rules[num]):
                ordering[i-1], ordering[i] = ordering[i], ordering[i-1]
                break
            seen.add(num)
        else:
            break


def solve():
    rules = {}
    for k, v in (r.split('|') for r in data.split('\n\n')[0].splitlines()):
        if k in rules:
            rules[k].add(v)
        else:
            rules[k] = {v}

    part1, part2 = 0, 0
    for ordering in data.split('\n\n')[1].splitlines():
        seen = set()
        ordering = ordering.split(',')
        for num in ordering:
            # print(num, seen, rules[num] if num in rules else {})
            if num in rules and seen.intersection(rules[num]):
                # print('FAILED')
                sort_pages(ordering, rules)
                part2 += int(ordering[len(ordering)//2])
                break
            seen.add(num)
        else:
            # print('PASSED!')
            part1 += int(ordering[len(ordering)//2])
    return part1, part2


print(solve())
