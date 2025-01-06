defmodule FoodOptions.DietaryOptionsHelper do
  @options %{
    "has_meat" => 1,
    "has_red_meat" => 2,
    "has_fish" => 4,
    "has_seafood" => 8,
    "has_poultry" => 16,
    "has_dairy" => 32,
    "has_egg" => 64,
    "has_gluten" => 128,
    "has_nuts" => 256,
    "has_soy" => 512,
    "has_legumes" => 1024,
    "has_added_sugar" => 2048,
    "has_alcohol" => 4096,
    "is_processed" => 8192,
    "is_spicy" => 16384,
    "is_vegan" => 32768,
    "is_halal" => 65536,
    "is_kosher" => 131_072,
    "is_low_fat" => 262_144,
    "is_low_carb" => 524_288
  }

  # Encode selected options into an integer bitstring
  def encode_options(selected_options) do
    selected_options
    |> Enum.reduce(0, fn option, acc ->
      acc |> Bitwise.bor(Map.get(@options, option, 0))
    end)
  end

  # Decode integer bitstring into a list of selected options
  def decode_options(bitstring) do
    @options
    |> Enum.filter(fn {_key, bit} -> bitstring |> Bitwise.band(bit) > 0 end)
    |> Enum.map(fn {key, _bit} -> key end)
  end

  # List all available options
  def available_options, do: Map.keys(@options)
end
