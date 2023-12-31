defmodule AttrsTest do
  use ExUnit.Case

  test "get" do
    assert Attrs.get(%{}, :foo) == nil
    assert Attrs.get(%{}, :foo, 0) == 0
    assert Attrs.get(%{foo: 1}, :foo, 0) == 1
    assert Attrs.get(%{"foo" => 1}, :foo, 0) == 1
    assert Attrs.get(%{"bar" => 1}, :foo, 0) == 0

    assert_raise ArgumentError, ~r"atom", fn ->
      Attrs.get(%{}, "foo")
    end
  end

  test "has?" do
    assert Attrs.has?(%{foo: 1}, :foo)
    assert Attrs.has?(%{"foo" => 1}, :foo)
    refute Attrs.has?(%{bar: 1}, :foo)

    assert_raise ArgumentError, ~r"atom", fn ->
      Attrs.has?(%{}, "foo")
    end
  end

  test "put" do
    assert Attrs.put(%{"foo" => 1}, :bar, 2) == %{"foo" => 1, "bar" => 2}
    assert Attrs.put(%{foo: 1}, :bar, 2) == %{foo: 1, bar: 2}
    assert Attrs.put(%{}, :foo, 1) == %{foo: 1}

    assert_raise ArgumentError, ~r"atom", fn ->
      Attrs.put(%{}, "foo", 1)
    end
  end

  test "merge" do
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

  test "normalize" do
    assert Attrs.normalize(%{"foo" => 1, "bar" => 2}) == %{"foo" => 1, "bar" => 2}
    assert Attrs.normalize(%{"foo" => 1, bar: 2}) == %{"foo" => 1, "bar" => 2}
    assert Attrs.normalize(%{foo: 1, bar: 2}) == %{foo: 1, bar: 2}
    assert Attrs.normalize(%{}) == %{}
  end
end
