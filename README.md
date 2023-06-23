# Attrs

Unifying atom and string key handling for user data (attrs maps) given to Ecto's cast function.

## Attrs.put(attrs, key, value)

```elixir
Attrs.put(%{"foo" => 1}, :bar, 2) == %{"foo" => 1, "bar" => 2}
Attrs.put(%{foo: 1}, :bar, 2) == %{foo: 1, bar: 2}
Attrs.put(%{}, :bar, 2) == %{bar: 2}
```

## Attrs.get(attrs, key, default)

```elixir
Attrs.get(%{foo: 1}, :foo) == 1
Attrs.get(%{"foo" => 1}, :foo) == 1
Attrs.get(%{foo: 1}, :bar) == nil
Attrs.get(%{foo: 1}, :bar, 2) == 2
```

## Attrs.has?(attrs, key)

```elixir
Attrs.has?(%{foo: 1}, :foo) == true
Attrs.has?(%{"foo" => 1}, :foo) == true
```

## Attrs.merge(attrs1, attrs2)

```elixir
Attrs.merge(%{"foo" => 1}, %{bar: 2}) == %{"foo" => 1, "bar" => 2}
Attrs.merge(%{"foo" => 1}, %{"bar" => 2}) == %{"foo" => 1, "bar" => 2}
Attrs.merge(%{foo: 1}, %{bar: 2}) == %{foo: 1, bar: 2}
```

## Attrs.normalize(attrs)

```elixir
Attrs.normalize(%{"foo" => 1, bar: 2}) == %{"foo" => 1, "bar" => 2}
Attrs.normalize(%{foo: 1, bar: 2}) == %{foo: 1, bar: 2}
Attrs.normalize(%{"foo" => 1, "bar" => 2}) == %{"foo" => 1, "bar" => 2}
```

## Installation

Add `attrs` for Elixir as a dependency in your `mix.exs` file:

```elixir
def deps do
  [
    {:attrs, "~> 0.2.0"}
  ]
end
```

## HexDocs

HexDocs documentation can be found at [https://hexdocs.pm/attrs](https://hexdocs.pm/attrs).
