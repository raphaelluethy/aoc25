def read_input(filename="in.txt"):
    left_list = []
    right_list = []

    with open(filename) as f:
        for line in f:
            left, right = line.strip().split()
            left_list.append(int(left))
            right_list.append(int(right))

    return left_list, right_list


def calculate_total_distance(left_list, right_list):
    left_sorted = sorted(left_list)
    right_sorted = sorted(right_list)

    total_distance = 0
    for l, r in zip(left_sorted, right_sorted):
        total_distance += abs(l - r)

    return total_distance


def calculate_similarity_score(left_list, right_list):
    right_counts = {}
    for num in right_list:
        right_counts[num] = right_counts.get(num, 0) + 1

    similarity_score = 0
    for num in left_list:
        similarity_score += num * right_counts.get(num, 0)

    return similarity_score


def main():
    left_list, right_list = read_input()
    if left_list and right_list:
        result1 = calculate_total_distance(left_list, right_list)
        print(f"Part 1 - Total distance: {result1}")

        result2 = calculate_similarity_score(left_list, right_list)
        print(f"Part 2 - Similarity score: {result2}")


if __name__ == "__main__":
    main()
