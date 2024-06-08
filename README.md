# Attrs

Unifying atom and string key handling for user data (attrs maps) given to Ecto's cast function.

## Problem

When working with Elixir's Phoenix Controllers or Absinthe, external data maps passed to `cast/4` must consist entirely of either atom keys or string keys, but cannot contain a mix of both types. This leads to tedious checks and potentially error-prone adjustments for data retrieval and insertion, since the key type must be accounted for each time:
```elixir
user_id = attrs[:user_id] || attrs["user_id"]
```

## Solution

```elixir
user_id = Attrs.get(attrs, :user_id)
```

Attrs enables handling of maps irrespective of whether they contain atom or string keys. It eliminates the distinction between the two key types, simplifying code when working with external data maps passed to `cast/4`.

Why "Attrs"? In Phoenix Contexts, user parameters and external data are often labeled as attrs, hence the name of this package.

## Attrs module

### `Attrs.get(attrs, key, default)`

```elixir
# Regardless of whether the key is a string or an atom, the value can be retrieved
Attrs.get(%{foo: 1}, :foo) == 1
Attrs.get(%{"foo" => 1}, :foo) == 1

# A default value may be provided in case the key is not found in the map
Attrs.get(%{foo: 1}, :bar) == nil
Attrs.get(%{foo: 1}, :bar, 2) == 2
```

### `Attrs.has_key?(attrs, key)`

```elixir
Attrs.has_key?(%{foo: 1}, :foo) == true
Attrs.has_key?(%{"foo" => 1}, :foo) == true
```

### `Attrs.has_keys?(attrs, key)`

```elixir
Attrs.has_keys?(%{foo: 1, bar: 2, "baz" => 3}, [:foo, :baz]) == true
```
### `Attrs.put(attrs, key, value)`

```elixir
# Preserve key type based on the first key returned from `Map.keys/1`.
Attrs.put(%{"foo" => 1}, :bar, 2) == %{"foo" => 1, "bar" => 2}
Attrs.put(%{foo: 1}, :bar, 2) == %{foo: 1, bar: 2}
```

### `Attrs.merge(attrs1, attrs2)`

```elixir
# Preserve key type based on the first key returned from `Map.keys/1`.
# If the key of either input map is a string key, the merged map will use string keys.
# If the keys of both input maps are atom keys, the merged map will use atom keys.
Attrs.merge(%{"foo" => 1}, %{bar: 2}) == %{"foo" => 1, "bar" => 2}
Attrs.merge(%{"foo" => 1}, %{"bar" => 2}) == %{"foo" => 1, "bar" => 2}
Attrs.merge(%{foo: 1}, %{bar: 2}) == %{foo: 1, bar: 2}
```

### `Attrs.normalize_keys(attrs)`

```elixir
# When normalizing key types, if the input map contains a mix of atom and string keys, all keys are converted to strings
Attrs.normalize_keys(%{"foo" => 1, bar: 2}) == %{"foo" => 1, "bar" => 2}

# If all keys are already atoms or strings, they are left unchanged
Attrs.normalize_keys(%{foo: 1, bar: 2}) == %{foo: 1, bar: 2}
Attrs.normalize_keys(%{"foo" => 1, "bar" => 2}) == %{"foo" => 1, "bar" => 2}
```

### `Attrs.stringify_keys(attrs)`

```elixir
Attrs.stringify_keys(%{"foo" => 1, bar: 2}) == %{"foo" => 1, "bar" => 2}
Attrs.stringify_keys(%{foo: 1, bar: 2}) == %{"foo" => 1, "bar" => 2}
Attrs.stringify_keys(%{"foo" => 1, "bar" => 2}) == %{"foo" => 1, "bar" => 2}
```

### Installation

Add `attrs` for Elixir as a dependency in your `mix.exs` file:

```elixir
def deps do
  [
    {:attrs, "~> 0.5.0"}
  ]
end
```

### HexDocs

HexDocs documentation can be found at [https://hexdocs.pm/attrs](https://hexdocs.pm/attrs).
