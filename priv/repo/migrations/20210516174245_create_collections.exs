defmodule ExJatl.Repo.Migrations.CreateCollections do
  use Ecto.Migration

  def change do
    create table(:collections) do
      add :name, :string
      add :description, :text

      timestamps()
    end

  end
end
