defmodule Solution do
  def main do
    mul_regex = ~r/mul\((\d+),(\d+)\)/
    mul_do_regex = ~r/(?:mul\((\d+),(\d+)\)|(do)\(\)|(don't)\(\))/

    lines = File.read!("in.txt") |> String.split("\n")

    # Part 1
    sum =
      lines
      |> Enum.flat_map(fn line ->
        Regex.scan(mul_regex, line, capture: :all_but_first)
      end)
      |> Enum.reduce(0, fn [num1, num2], acc ->
        acc + String.to_integer(num1) * String.to_integer(num2)
      end)

    IO.puts(sum)

    # Part 2
    instructions =
      lines
      |> Enum.flat_map(fn line ->
        Regex.scan(mul_do_regex, line)
      end)

    {sum2, _} =
      instructions
      |> Enum.reduce({0, true}, fn [_match | captures], {acc, is_do} ->
        cond do
          Enum.any?(captures, &(&1 == "do")) ->
            {acc, true}

          Enum.any?(captures, &(&1 == "don't")) ->
            {acc, false}

          is_do ->
            numbers =
              captures
              |> Enum.filter(&(not is_nil(&1)))
              |> Enum.filter(&Regex.match?(~r/^\d+$/, &1))

            case numbers do
              [num1, num2] -> {acc + String.to_integer(num1) * String.to_integer(num2), is_do}
              _ -> {acc, is_do}
            end

          true ->
            {acc, is_do}
        end
      end)

    IO.puts(sum2)
  end
end

Solution.main()
