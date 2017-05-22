defmodule HelloWorld do
  @moduledoc """
  Elixir counts the number of arguments as part of the function name.
  For instance;

      def hello() do
      end

  would be a completely different function from

      def hello(name) do
      end

  Can you find a way to make all the tests pass with just one
  function?

  Hint: look into argument defaults here:
  http://elixir-lang.org/getting-started/modules.html#default-arguments
  """

  @doc """

  Greets the user by name with an age-appropriate greeting, or by saying "Hello,

  World! Now get off my lawn."  " if no name is given.

  By "age-appropriate" I of course mean MY age, which is grumpy old man.

  P.S. Yes I amended the specs to include the yard-clearing imperative.
  """
  @spec hello(String.t) :: String.t
  def hello(name \\ "World") do
    "Hello, #{name}! Now get off my lawn."
  end
end
