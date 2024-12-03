import re


def main():
    mul_regex = re.compile(r"mul\((\d+),(\d+)\)", re.MULTILINE)
    mul_do_regex = re.compile(
        r"(?:mul\((\d+),(\d+)\)|(do)\(\)|(don't)\(\))", re.MULTILINE
    )
    instructions = []
    instructions2 = []
    sum = 0
    sum2 = 0
    with open("in.txt", "r") as f:
        lines = f.readlines()
        for line in lines:
            res = mul_regex.findall(line)
            for i in res:
                instructions.append(i)

        for line in lines:
            res = mul_do_regex.findall(line)
            for i in res:
                instructions2.append(i)

    # print(instructions)
    for instruction in instructions:
        sum += int(instruction[0]) * int(instruction[1])

    print(sum)

    isDo = True
    for instruction in instructions2:
        if "do" in instruction:
            isDo = True
        elif "don't" in instruction:
            isDo = False

        if isDo:
            numbers = [x for x in instruction if x.isdigit()]

            sum2 += int(numbers[0]) * int(numbers[1]) if len(numbers) == 2 else 0

    print(sum2)


if __name__ == "__main__":
    main()
