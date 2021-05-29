defmodule ExJatl.Todos.Collection do
  use Ecto.Schema
  import Ecto.Changeset
  alias ExJatl.Todos.Todo

  schema "collections" do
    field :name, :string
    field :description, :string
    timestamps()

    has_many(:todos, Todo, on_replace: :delete)
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> cast_assoc(:todos)
  end
end
