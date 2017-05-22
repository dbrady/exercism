defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text |> String.split("") |> Enum.map(&(rotate_char(&1,shift))) |> Enum.join("")
  end

  def rotate_char(char, shift) when shift==0 or shift==26, do: char

  def rotate_char(char, _) when char == "", do: char

  def rotate_char(char, shift) do
    # WOOF. There's GOT to be a sleek and sexy way to do this
    # For now, do it fat and slobbery
    plain_int = char_to_int(char)
    base = cond do
      plain_int in ?A..?Z -> ?A
      plain_int in ?a..?z -> ?a
      true -> 0
    end

    cipher_int = if base > 0 do
      rem((plain_int - base) + shift, 26) + base
    else
      plain_int
    end

    int_to_char(cipher_int)
  end

  def char_to_int(char) do
    elem(List.to_tuple(String.to_charlist(char)), 0)
  end

  def int_to_char(int) do
    List.to_string Tuple.to_list({int})
  end
end
