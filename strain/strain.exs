defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep([], fun), do: []
  def keep(list, fun) do
    # Enum.filter_map(list, fun, &(&1)) # WHAAAAAAT. It's not Enum.filter...
    if fun.(hd(list)) do
      [hd(list) | keep(tl(list), fun)]
    else
      keep(tl(list), fun)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard([], fun), do: []
  def discard(list, fun) do
    if fun.(hd(list)) do
      discard(tl(list), fun)
    else
      [hd(list) | discard(tl(list), fun)]
    end
  end
end
