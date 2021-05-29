defmodule ExJatl.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :collection_id, references(:collections, on_delete: :delete_all), null: false
      add :title, :string
      add :description, :text
      add :completed, :boolean, default: false, null: false

      timestamps()
    end

    create index(:todos, [:collection_id])

  end
end
