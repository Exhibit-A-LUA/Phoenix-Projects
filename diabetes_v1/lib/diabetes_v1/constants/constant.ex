defmodule DiabetesV1.Constants.Constant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "constants" do
    field :value, :float
    field :description, :string
    field :key, :string
    field :notes, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(constant, attrs) do
    constant
    |> cast(attrs, [:key, :value, :description, :notes])
    |> validate_required([:key, :value])
    |> unique_constraint(:key)
  end
end
