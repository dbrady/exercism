defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  use Bitwise

  @codes ["wink", "double blink", "close your eyes", "jump", :reverse]

  @spec commands(code :: integer) :: list(String.t())

  # Strip off any bits above lower 5
  # We could do this directly inside the other commands/1 call, but I<3SRP
  def commands(code) when code > 31, do: commands(code &&& 31)

  # Start off recursion by calling commands/3 with initialized &2 and &3
  def commands(code), do: commands(code, @codes, [])

  # RESEARCH: Per the style guide, don't mix inline functions with multiline. Is
  # it ok to inline all the commands/1 and multiline all the commands/3? If not,
  # they should probably all be expanded. If yes, is this a good line of
  # separation? Could I get away with inlining the first commands/3 method,
  # since it's the recursion-ending base case, while all of the others continue
  # the recursion?

  # BASE CASE! code is 0, we're out of commands -- return output
  def commands(0, _, output) do
    output
  end

  # RESEARCH: The following commands/3 all execute a command and recurse. But
  # they *also* muck around with the list. Is the hairy guard clause on the
  # reverse method a smell of SRP violation here?

  # command is enabled and current_code is :reverse -- reverse the output and recurse
  def commands(code, [current_code | tail], output) when ((code &&& 1) == 1 and current_code == :reverse) do
    commands(code >>> 1, tail, Enum.reverse(output))
  end

  # command is enabled -- add current_code to the output and recurse
  def commands(code, [current_code | tail], output) when (code &&& 1) == 1 do
    commands(code >>> 1, tail, output ++ [current_code])
  end

  # command is disabled -- skip this code and recurse
  def commands(code, [_ | tail], output) do
    commands(code >>> 1, tail, output)
  end
end
