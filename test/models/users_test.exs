defmodule SiBlog.UsersTest do
  use SiBlog.ModelCase

  alias SiBlog.Users

  @valid_attrs %{email: "test@example.com", password: "testpass",
password_confirmation: "testpass", username:
"test_user"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Users.changeset(%Users{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Users.changeset(%Users{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "password_digest is set to hash" do
    changeset = Users.changeset(%Users{}, @invalid_attrs)
    assert get_change(changeset, :password_digest) == "IMAHASH"
  end
end
