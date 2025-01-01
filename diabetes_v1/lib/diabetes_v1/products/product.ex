defmodule DiabetesV1.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :sugars_g, :float
    field :v_b2_riboflavin_mg, :float
    field :v_e_mg, :float
    field :mono_g, :float
    field :iron_mg, :float
    field :starch_g, :float
    field :v_k_mcg, :float
    field :v_b5_mg, :float
    field :carbs_g, :float
    field :zinc_mg, :float
    field :description, :string
    field :copper_mg, :float
    field :serving_g, :float
    field :name, :string
    field :calories_kcal, :float
    field :sat_g, :float
    field :phosphorus_mg, :float
    field :v_b3_niacin_mg, :float
    field :v_b1_thiamin_mg, :float
    field :cholesterol_mg, :float
    field :v_d_mcg, :float
    field :sodium_mg, :float
    field :v_b6_mg, :float
    field :poly_g, :float
    field :choline_mg, :float
    field :v_b12_mg, :float
    field :potassium_mg, :float
    field :trans_g, :float
    field :calcium_mg, :float
    field :glycemix_index, :float
    field :protein_g, :float
    field :fibre_g, :float
    field :v_a_retinol_mcg, :float
    field :sugar_alcohol_g, :float
    field :magnesium_mg, :float
    field :v_b9_folate_mcg, :float
    field :selenium_mcg, :float
    field :v_c_ascorbic_acid_mg, :float
    field :fat_g, :float
    field :serving_descr, :string

    belongs_to :main_type, DiabetesV1.ProductMainTypes.ProductMainType, foreign_key: :main_type_id
    belongs_to :sub_type, DiabetesV1.ProductSubTypes.ProductSubType, foreign_key: :sub_type_id
    belongs_to :category, DiabetesV1.ProductCategories.ProductCategory, foreign_key: :category_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [
      :id,
      :name,
      :description,
      :serving_g,
      :serving_descr,
      :calories_kcal,
      :carbs_g,
      :fibre_g,
      :starch_g,
      :sugars_g,
      :sugar_alcohol_g,
      :protein_g,
      :fat_g,
      :mono_g,
      :trans_g,
      :poly_g,
      :sat_g,
      :cholesterol_mg,
      :glycemix_index,
      :calcium_mg,
      :iron_mg,
      :magnesium_mg,
      :phosphorus_mg,
      :potassium_mg,
      :sodium_mg,
      :zinc_mg,
      :copper_mg,
      :selenium_mcg,
      :choline_mg,
      :v_a_retinol_mcg,
      :v_b1_thiamin_mg,
      :v_b2_riboflavin_mg,
      :v_b3_niacin_mg,
      :v_b5_mg,
      :v_b6_mg,
      :v_b9_folate_mcg,
      :v_b12_mg,
      :v_c_ascorbic_acid_mg,
      :v_d_mcg,
      :v_e_mg,
      :v_k_mcg
    ])
    |> validate_required([
      :name,
      :description,
      :serving_g,
      :serving_descr,
      :calories_kcal,
      :carbs_g,
      :fibre_g,
      :starch_g,
      :sugars_g,
      :sugar_alcohol_g,
      :protein_g,
      :fat_g,
      :mono_g,
      :trans_g,
      :poly_g,
      :sat_g,
      :cholesterol_mg,
      :glycemix_index,
      :calcium_mg,
      :iron_mg,
      :magnesium_mg,
      :phosphorus_mg,
      :potassium_mg,
      :sodium_mg,
      :zinc_mg,
      :copper_mg,
      :selenium_mcg,
      :choline_mg,
      :v_a_retinol_mcg,
      :v_b1_thiamin_mg,
      :v_b2_riboflavin_mg,
      :v_b3_niacin_mg,
      :v_b5_mg,
      :v_b6_mg,
      :v_b9_folate_mcg,
      :v_b12_mg,
      :v_c_ascorbic_acid_mg,
      :v_d_mcg,
      :v_e_mg,
      :v_k_mcg
    ])
    |> unique_constraint(:name)
  end
end
