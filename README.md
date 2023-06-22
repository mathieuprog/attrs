# Attrs

Unifying atom and string key handling for user data (attrs maps) given to Ecto's cast function

## Attrs.get(attrs, key, default)

```elixir
Attrs.get(%{foo: 1}, :foo) == 1
Attrs.get(%{"foo" => 1}, :foo) == 1
Attrs.get(%{foo: 1}, :bar, 2) == 2
```

## Attrs.put(attrs, key, value)

```elixir
Attrs.put(%{"foo" => 1}, :bar, 2) == %{"foo" => 1, "bar" => 2}
Attrs.put(%{foo: 1}, :bar, 2) == %{foo: 1, bar: 2}
Attrs.put(%{}, :bar, 2) == %{bar: 2}
```

## Attrs.merge(attrs1, attrs2)

```elixir
Attrs.merge(%{"foo" => 1}, %{bar: 2}) == %{"foo" => 1, "bar" => 2}
Attrs.merge(%{"foo" => 1}, %{"bar" => 2}) == %{"foo" => 1, "bar" => 2}
Attrs.merge(%{foo: 1}, %{bar: 2}) == %{foo: 1, bar: 2}
```

## Attrs.normalize_keys(attrs)

```elixir
Attrs.normalize_keys(%{"foo" => 1, bar: 2}) == %{"foo" => 1, "bar" => 2}
Attrs.normalize_keys(%{foo: 1, bar: 2}) == %{foo: 1, bar: 2}
Attrs.normalize_keys(%{"foo" => 1, "bar" => 2}) == %{"foo" => 1, "bar" => 2}
```
