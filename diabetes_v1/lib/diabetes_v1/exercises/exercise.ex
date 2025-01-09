defmodule DiabetesV1.Exercises.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercises" do
    field :type, :string
    field :description, :string
    field :intensity, Ecto.Enum, values: [:low, :moderate, :vigorous]
    field :met, :float

    has_many :times, DiabetesV1.Times.Time

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:type, :intensity, :met, :description])
    |> validate_required([:type, :intensity, :met])
    |> unique_constraint(:type)
  end
end
