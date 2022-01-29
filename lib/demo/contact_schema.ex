defmodule Demo.ContactSchema do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :subject, :string
    field :name, :string
    field :email, :string
    field :contact_number, :string
    field :message, :string
  end

  @doc false
  def changeset(contact, attrs \\ %{}) do
    contact
    |> cast(attrs, [:subject, :name, :email, :contact_number, :message])
    |> validate_required([:subject, :name, :email, :contact_number, :message])
  end
end
