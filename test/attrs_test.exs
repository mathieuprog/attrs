defmodule AttrsTest do
  use ExUnit.Case

  test "get/3" do
    assert Attrs.get(%{}, :foo) == nil
    assert Attrs.get(%{}, :foo, 0) == 0
    assert Attrs.get(%{foo: 1}, :foo, 0) == 1
    assert Attrs.get(%{"foo" => 1}, :foo, 0) == 1
    assert Attrs.get(%{"bar" => 1}, :foo, 0) == 0

    assert_raise ArgumentError, ~r"atom", fn ->
      Attrs.get(%{}, "foo")
    end
  end

  test "has_key?/2" do
    assert Attrs.has_key?(%{foo: 1}, :foo)
    assert Attrs.has_key?(%{"foo" => 1}, :foo)
    refute Attrs.has_key?(%{bar: 1}, :foo)

    assert_raise ArgumentError, ~r"atom", fn ->
      Attrs.has_key?(%{}, "foo")
    end
  end

  test "put/3" do
    assert Attrs.put(%{"foo" => 1}, :bar, 2) == %{"foo" => 1, "bar" => 2}
    assert Attrs.put(%{:foo => 1, "bar" => 2}, :baz, 3) == %{:foo => 1, "bar" => 2, :baz => 3}
    assert Attrs.put(%{foo: 1}, :bar, 2) == %{foo: 1, bar: 2}
    assert Attrs.put(%{}, :foo, 1) == %{foo: 1}

    assert_raise ArgumentError, ~r"atom", fn ->
      Attrs.put(%{}, "foo", 1)
    end
  end

  test "merge/2" do
    assert Attrs.merge(%{"foo" => 1}, %{"bar" => 2}) == %{"foo" => 1, "bar" => 2}
    assert Attrs.merge(%{foo: 1}, %{bar: 2}) == %{foo: 1, bar: 2}
    assert Attrs.merge(%{"foo" => 1}, %{bar: 2}) == %{"foo" => 1, "bar" => 2}
    assert Attrs.merge(%{foo: 1}, %{"bar" => 2}) == %{"foo" => 1, "bar" => 2}
    assert Attrs.merge(%{}, %{}) == %{}
    assert Attrs.merge(%{"foo" => 1}, %{}) == %{"foo" => 1}
    assert Attrs.merge(%{foo: 1}, %{}) == %{foo: 1}
    assert Attrs.merge(%{}, %{"foo" => 1}) == %{"foo" => 1}
    assert Attrs.merge(%{}, %{foo: 1}) == %{foo: 1}
  end

  test "normalize_keys/1" do
    assert Attrs.normalize_keys(%{"foo" => 1, "bar" => 2}) == %{"foo" => 1, "bar" => 2}
    assert Attrs.normalize_keys(%{"foo" => 1, bar: 2}) == %{"foo" => 1, "bar" => 2}
    assert Attrs.normalize_keys(%{foo: 1, bar: 2}) == %{foo: 1, bar: 2}
    assert Attrs.normalize_keys(%{}) == %{}
  end

  test "stringify_keys/1" do
    assert Attrs.stringify_keys(%{"foo" => 1, "bar" => 2}) == %{"foo" => 1, "bar" => 2}
    assert Attrs.stringify_keys(%{"foo" => 1, bar: 2}) == %{"foo" => 1, "bar" => 2}
    assert Attrs.stringify_keys(%{foo: 1, bar: 2}) == %{"foo" => 1, "bar" => 2}
    assert Attrs.stringify_keys(%{}) == %{}
  end
end
