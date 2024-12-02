MAX_DIFF = 3
MIN_DIFF = 1


def is_valid(l):
    is_sorted = all(l[i] < l[i + 1] for i in range(len(l) - 1)) or all(
        l[i] > l[i + 1] for i in range(len(l) - 1)
    )
    correct_diff = [
        MIN_DIFF <= abs(l[i + 1] - l[i]) <= MAX_DIFF for i in range(len(l) - 1)
    ]

    correct_diff = all(x for x in correct_diff)
    return is_sorted and correct_diff


def is_valid_v2(l):
    # Try removing each number once and check if any resulting sequence is valid
    for i in range(len(l)):
        test_list = l[:i] + l[i + 1 :]

        if is_valid(test_list):
            return True

    return is_valid(l)


def main():
    with open("in.txt") as f:
        lines = f.readlines()
        lines = [line.strip() for line in lines]
        lines = [line.split(" ") for line in lines]
        lines = [[int(x) for x in line] for line in lines]

        print(sum(is_valid_v2(line) for line in lines))


if __name__ == "__main__":
    main()
