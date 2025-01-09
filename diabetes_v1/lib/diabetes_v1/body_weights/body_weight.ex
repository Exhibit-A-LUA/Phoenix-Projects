defmodule DiabetesV1.BodyWeights.BodyWeight do
  use Ecto.Schema
  import Ecto.Changeset

  schema "body_weights" do
    field :reading_date, :date
    field :weight_kg, :float
    belongs_to :user, DiabetesV1.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(body_weight, attrs) do
    body_weight
    |> cast(attrs, [:user_id, :reading_date, :weight_kg])
    |> validate_required([:user_id, :reading_date, :weight_kg])
    |> unique_constraint([:user_id, :reading_date],
      name: :body_weights_user_id_reading_date_index
    )
  end
end
