defmodule SiBlog.UsersControllerTest do
  use SiBlog.ConnCase

  alias SiBlog.Users
  @valid_create_attrs %{email: "test@example.com", password: "testpass",
    password_confirmation: "testpass", username: "test_user"}
  @valid_attrs %{email: "test@example.com", username: "test_user"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, users_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing users"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, users_path(conn, :new)
    assert html_response(conn, 200) =~ "New users"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, users_path(conn, :create), users: @valid_create_attrs
    assert redirected_to(conn) == users_path(conn, :index)
    assert Repo.get_by(Users, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, users_path(conn, :create), users: @invalid_attrs
    assert html_response(conn, 200) =~ "New users"
  end

  test "shows chosen resource", %{conn: conn} do
    users = Repo.insert! %Users{}
    conn = get conn, users_path(conn, :show, users)
    assert html_response(conn, 200) =~ "Show users"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, users_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    users = Repo.insert! %Users{}
    conn = get conn, users_path(conn, :edit, users)
    assert html_response(conn, 200) =~ "Edit users"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    users = Repo.insert! %Users{}
    conn = put conn, users_path(conn, :update, users), users: @valid_create_attrs
    assert redirected_to(conn) == users_path(conn, :show, users)
    assert Repo.get_by(Users, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    users = Repo.insert! %Users{}
    conn = put conn, users_path(conn, :update, users), users: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit users"
  end

  test "deletes chosen resource", %{conn: conn} do
    users = Repo.insert! %Users{}
    conn = delete conn, users_path(conn, :delete, users)
    assert redirected_to(conn) == users_path(conn, :index)
    refute Repo.get(Users, users.id)
  end
end
