defmodule DiabetesV1.Repo do
  use Ecto.Repo,
    otp_app: :diabetes_v1,
    adapter: Ecto.Adapters.Postgres
end
