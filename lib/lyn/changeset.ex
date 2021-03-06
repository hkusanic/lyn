defmodule Lyn.Changeset do
  @moduledoc false
  alias __MODULE__, as: Cs
  defstruct valid?: true, changeset: nil, errors: nil, dependents: []

  def update(%Cs{} = r, items) when is_list(items) do
    Enum.reduce(items, r, fn({k,v}, acc) -> update(acc, k, v) end)
  end
  def update(%Cs{} = r, :changeset, changeset) do
    %Cs{r | changeset: changeset}
  end
  def update(%Cs{valid?: valid?} = r, :valid?, value) do
    %Cs{r | valid?: valid? and value}
  end
  def update(%Cs{dependents: dependents} = r, :dependents, dependent) do
    %Cs{r | dependents: dependents ++ [dependent]}
  end
  def update(%Cs{} = r, :errors, nil), do: r
  def update(%Cs{errors: nil} = r, :errors, error) do
    %Cs{r | errors: error}
  end
  def update(%Cs{errors: errors} = r, :errors, error) do
    %Cs{r | errors: errors ++ error}
  end
end
