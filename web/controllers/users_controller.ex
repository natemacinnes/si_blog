defmodule SiBlog.UsersController do
  use SiBlog.Web, :controller

  alias SiBlog.Users

  def index(conn, _params) do
    users = Repo.all(Users)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Users.changeset(%Users{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"users" => users_params}) do
    changeset = Users.changeset(%Users{}, users_params)

    case Repo.insert(changeset) do
      {:ok, _users} ->
        conn
        |> put_flash(:info, "Users created successfully.")
        |> redirect(to: users_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    users = Repo.get!(Users, id)
    render(conn, "show.html", users: users)
  end

  def edit(conn, %{"id" => id}) do
    users = Repo.get!(Users, id)
    changeset = Users.changeset(users)
    render(conn, "edit.html", users: users, changeset: changeset)
  end

  def update(conn, %{"id" => id, "users" => users_params}) do
    users = Repo.get!(Users, id)
    changeset = Users.changeset(users, users_params)

    case Repo.update(changeset) do
      {:ok, users} ->
        conn
        |> put_flash(:info, "Users updated successfully.")
        |> redirect(to: users_path(conn, :show, users))
      {:error, changeset} ->
        render(conn, "edit.html", users: users, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    users = Repo.get!(Users, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(users)

    conn
    |> put_flash(:info, "Users deleted successfully.")
    |> redirect(to: users_path(conn, :index))
  end
end
