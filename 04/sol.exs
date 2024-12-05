# DISCLAIMER: I have no idea what I'm doing and also the code is false lol.
# I am not a functional bro :(

defmodule TextParser do
  def parse_file_to_matrix(file_path) do
    # Read the file contents
    File.read!(file_path)
    # Split into lines and remove empty lines
    |> String.split("\n", trim: true)
    # Convert each line to a list of characters
    |> Enum.map(&String.graphemes/1)
  end
end

defmodule Solution do
  def part1(matrix) do
    res =
      Enum.reduce(Enum.with_index(matrix), 0, fn {row, row_index}, count ->
        count +
          Enum.reduce(Enum.with_index(row), 0, fn {_char, col_index}, inner_count ->
            # Up
            # Down
            # Left
            # Right
            inner_count +
              check_for_xmas(matrix, row_index, col_index, -1, 0) +
              check_for_xmas(matrix, row_index, col_index, 1, 0) +
              check_for_xmas(matrix, row_index, col_index, 0, -1) +
              check_for_xmas(matrix, row_index, col_index, 0, 1)
          end)
      end)

    IO.inspect(res)
  end

  def check_for_xmas(matrix, row_index, col_index, row_delta, col_delta) do
    # Calculate the positions for X, M, A, S based on deltas
    x_pos = {row_index, col_index}
    m_pos = {row_index + row_delta, col_index + col_delta}
    a_pos = {row_index + 2 * row_delta, col_index + 2 * col_delta}
    s_pos = {row_index + 3 * row_delta, col_index + 3 * col_delta}

    # Check if the positions are within bounds
    if valid_position?(matrix, x_pos) and valid_position?(matrix, m_pos) and
         valid_position?(matrix, a_pos) and valid_position?(matrix, s_pos) do
      if Enum.at(Enum.at(matrix, elem(x_pos, 0)), elem(x_pos, 1)) == "X" and
           Enum.at(Enum.at(matrix, elem(m_pos, 0)), elem(m_pos, 1)) == "M" and
           Enum.at(Enum.at(matrix, elem(a_pos, 0)), elem(a_pos, 1)) == "A" and
           Enum.at(Enum.at(matrix, elem(s_pos, 0)), elem(s_pos, 1)) == "S" do
        1
      else
        if Enum.at(Enum.at(matrix, elem(x_pos, 0)), elem(x_pos, 1)) == "S" and
             Enum.at(Enum.at(matrix, elem(m_pos, 0)), elem(m_pos, 1)) == "A" and
             Enum.at(Enum.at(matrix, elem(a_pos, 0)), elem(a_pos, 1)) == "M" and
             Enum.at(Enum.at(matrix, elem(s_pos, 0)), elem(s_pos, 1)) == "X" do
          1
        else
          0
        end
      end
    else
      0
    end
  end

  defp valid_position?(matrix, {row, col}) do
    row >= 0 and row < length(matrix) and col >= 0 and col < length(Enum.at(matrix, row))
  end
end

# Example usage:
file_path = "in.txt"
matrix = TextParser.parse_file_to_matrix(file_path)
Solution.part1(matrix)
