defmodule SiBlog.Users do
  use SiBlog.Web, :model

  schema "users" do
    field :username, :string
    field :email, :string
    field :password_digest, :string

    timestamps()
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :password, :password_confirmation])
    |> validate_required([:username, :email, :password,
:password_confirmation])
    |> hash_password
  end

  defp hash_password(changeset) do
    changeset
    |> put_change(:password_digest, "IMAHASH")
  end
end
