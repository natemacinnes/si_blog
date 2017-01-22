defmodule SiBlog.UsersTest do
  use SiBlog.ModelCase

  alias SiBlog.Users

  @valid_attrs %{email: "some content", password_digest: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Users.changeset(%Users{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Users.changeset(%Users{}, @invalid_attrs)
    refute changeset.valid?
  end
end
