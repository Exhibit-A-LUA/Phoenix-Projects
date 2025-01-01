defmodule DiabetesV1.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :description, :text
      add :serving_g, :float
      add :serving_descr, :string
      add :calories_kcal, :float
      add :carbs_g, :float
      add :fibre_g, :float
      add :starch_g, :float
      add :sugars_g, :float
      add :sugar_alcohol_g, :float
      add :protein_g, :float
      add :fat_g, :float
      add :mono_g, :float
      add :trans_g, :float
      add :poly_g, :float
      add :sat_g, :float
      add :cholesterol_mg, :float
      add :glycemix_index, :float
      add :calcium_mg, :float
      add :iron_mg, :float
      add :magnesium_mg, :float
      add :phosphorus_mg, :float
      add :potassium_mg, :float
      add :sodium_mg, :float
      add :zinc_mg, :float
      add :copper_mg, :float
      add :selenium_mcg, :float
      add :choline_mg, :float
      add :v_a_retinol_mcg, :float
      add :v_b1_thiamin_mg, :float
      add :v_b2_riboflavin_mg, :float
      add :v_b3_niacin_mg, :float
      add :v_b5_mg, :float
      add :v_b6_mg, :float
      add :v_b9_folate_mcg, :float
      add :v_b12_mg, :float
      add :v_c_ascorbic_acid_mg, :float
      add :v_d_mcg, :float
      add :v_e_mg, :float
      add :v_k_mcg, :float
      add :main_type_id, references(:product_main_types, on_delete: :nothing), null: false
      add :sub_type_id, references(:product_sub_types, on_delete: :nothing), null: false
      add :category_id, references(:product_categories, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:products, [:main_type_id])
    create index(:products, [:sub_type_id])
    create index(:products, [:category_id])
    create unique_index(:products, [:name])
  end
end
