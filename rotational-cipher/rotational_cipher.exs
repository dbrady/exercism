defmodule RotationalCipher do
  use Bitwise

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

  # This essentially only handles the empty/end-of-string case.
  def rotate(text, shift) do
    text
  end

  def rotate_char(char, shift) when char in ?A..?Z or char in ?a..?z do
    rem(((char &&& 95) - ?A) + shift, 26) + ?A ||| (char &&& 32)
  end

  def rotate_char(char, _shift) do
    char
  end
end
