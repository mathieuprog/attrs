defmodule Attrs do
  def get(attrs, key, default \\ nil)

  def get(%{} = attrs, key, default) when is_atom(key) do
    Map.get(attrs, key, Map.get(attrs, to_string(key), default))
  end

  def get(%{}, key, _default) when is_binary(key) do
    raise ArgumentError, message: "key passed to Attrs.get/3 must be an atom"
  end

  def has_key?(attrs, key) when is_atom(key) do
    Map.has_key?(attrs, key) || Map.has_key?(attrs, to_string(key))
  end

  def has_key?(%{}, key) when is_binary(key) do
    raise ArgumentError, message: "key passed to Attrs.has_key?/2 must be an atom"
  end

  def put(%{} = attrs, key, value) when is_atom(key) and map_size(attrs) == 0 do
    %{key => value}
  end

  def put(%{} = attrs, key, value) when is_atom(key) do
    [existing_key | _] = Map.keys(attrs)

    cond do
      is_binary(existing_key) ->
        Map.put(attrs, to_string(key), value)

      true ->
        Map.put(attrs, key, value)
    end
  end

  def put(%{}, key, _value) when is_binary(key) do
    raise ArgumentError, message: "key passed to Attrs.put/3 must be an atom"
  end

  def normalize_keys(%{} = attrs) do
    cond do
      Enum.all?(attrs, fn {key, _} -> is_atom(key) end) -> attrs
      Enum.all?(attrs, fn {key, _} -> is_binary(key) end) -> attrs
      true -> map_keys_to_string_keys(attrs)
    end
  end

  def stringify_keys(%{} = attrs) do
    map_keys_to_string_keys(attrs)
  end

  def merge(%{} = attrs1, %{} = attrs2) when map_size(attrs1) == 0 do
    attrs2
  end

  def merge(%{} = attrs1, %{} = attrs2) when map_size(attrs2) == 0 do
    attrs1
  end

  def merge(%{} = attrs1, %{} = attrs2) do
    [key1 | _] = Map.keys(attrs1)
    [key2 | _] = Map.keys(attrs2)

    cond do
      is_binary(key1) and is_atom(key2) ->
        attrs2 = map_keys_to_string_keys(attrs2)
        Map.merge(attrs1, attrs2)

      is_binary(key2) and is_atom(key1) ->
        attrs1 = map_keys_to_string_keys(attrs1)
        Map.merge(attrs1, attrs2)

      true ->
        Map.merge(attrs1, attrs2)
    end
  end

  defp map_keys_to_string_keys(%{} = map),
    do: for({key, val} <- map, into: %{}, do: {to_string(key), val})
end
