# Attrs

Unifying atom and string key handling for user data (attrs maps) given to Ecto's cast function.

## Problem

When working with Elixir's Phoenix Controllers or Absinthe, external data maps passed to `cast/4` must consist entirely of either atom keys or string keys, but cannot contain a mix of both types. This leads to tedious checks and potentially error-prone adjustments for data retrieval and insertion, since the key type must be accounted for each time:
```elixir
user_id = attrs[:user_id] || attrs["user_id"]
```

## Solution

Attrs enables handling of maps irrespective of whether they contain atom or string keys. It eliminates the distinction between the two key types, simplifying code when working with external data maps passed to `cast/4`.

Why "Attrs"? In Phoenix Contexts, user parameters and external data are often labeled as attrs, hence the name of this package.

## Attrs module

### `Attrs.put(attrs, key, value)`

```elixir
# If the map contains string keys, ensure the new entry is added with a string key
Attrs.put(%{"foo" => 1}, :bar, 2) == %{"foo" => 1, "bar" => 2}

# If the map contains atom keys, ensure the new entry is added with an atom key
Attrs.put(%{foo: 1}, :bar, 2) == %{foo: 1, bar: 2}
```

### `Attrs.get(attrs, key, default)`

```elixir
# Regardless of whether the key is a string or an atom, the value can be retrieved
Attrs.get(%{foo: 1}, :foo) == 1
Attrs.get(%{"foo" => 1}, :foo) == 1

# A default value may be provided in case the key is not found in the map
Attrs.get(%{foo: 1}, :bar) == nil
Attrs.get(%{foo: 1}, :bar, 2) == 2
```

### `Attrs.has?(attrs, key)`

```elixir
Attrs.has?(%{foo: 1}, :foo) == true
Attrs.has?(%{"foo" => 1}, :foo) == true
```

### `Attrs.merge(attrs1, attrs2)`

```elixir
# If either of the input maps has string keys, the merged map will also use string keys
Attrs.merge(%{"foo" => 1}, %{bar: 2}) == %{"foo" => 1, "bar" => 2}
Attrs.merge(%{"foo" => 1}, %{"bar" => 2}) == %{"foo" => 1, "bar" => 2}

# If both input maps use atom keys, the merged map will maintain the use of atom keys
Attrs.merge(%{foo: 1}, %{bar: 2}) == %{foo: 1, bar: 2}
```

### `Attrs.normalize(attrs)`

```elixir
# When normalizing key types, if the input map contains a mix of atom and string keys, all keys are converted to strings
Attrs.normalize(%{"foo" => 1, bar: 2}) == %{"foo" => 1, "bar" => 2}

# If all keys are already atoms or strings, they are left unchanged
Attrs.normalize(%{foo: 1, bar: 2}) == %{foo: 1, bar: 2}
Attrs.normalize(%{"foo" => 1, "bar" => 2}) == %{"foo" => 1, "bar" => 2}
```

### Installation

Add `attrs` for Elixir as a dependency in your `mix.exs` file:

```elixir
def deps do
  [
    {:attrs, "~> 0.3.0"}
  ]
end
```

### HexDocs

HexDocs documentation can be found at [https://hexdocs.pm/attrs](https://hexdocs.pm/attrs).
