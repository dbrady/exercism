defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) when shift == 0 or shift == 26 do
    text
  end

  def rotate(<<char :: 8, tail :: binary>>, shift) do
    <<rotate_char(char, shift)>> <> rotate(tail, shift)
  end

  def rotate(<<tail :: binary>>, shift) do
    tail
  end

  def rotate_char(char, shift) when char in ?A..?Z do
    rem((char - ?A) + shift, 26) + ?A
  end

  def rotate_char(char, shift) when char in ?a..?z do
    rem((char - ?a) + shift, 26) + ?a
  end

  def rotate_char(char, _shift) do
    char
  end
end
