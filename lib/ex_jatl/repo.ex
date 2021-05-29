defmodule ExJatl.Repo do
  use Phoenix.Pagination, per_page: 20
  use Ecto.Repo,
    otp_app: :ex_jatl,
    adapter: Ecto.Adapters.MyXQL
end
