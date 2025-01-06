defmodule FoodOptionsWeb.DietaryOptionLiveTest do
  use FoodOptionsWeb.ConnCase

  import Phoenix.LiveViewTest
  import FoodOptions.DietaryOptionsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_dietary_option(_) do
    dietary_option = dietary_option_fixture()
    %{dietary_option: dietary_option}
  end

  describe "Index" do
    setup [:create_dietary_option]

    test "lists all dietary_options", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/dietary_options")

      assert html =~ "Listing Dietary options"
    end

    test "saves new dietary_option", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/dietary_options")

      assert index_live |> element("a", "New Dietary option") |> render_click() =~
               "New Dietary option"

      assert_patch(index_live, ~p"/dietary_options/new")

      assert index_live
             |> form("#dietary_option-form", dietary_option: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#dietary_option-form", dietary_option: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/dietary_options")

      html = render(index_live)
      assert html =~ "Dietary option created successfully"
    end

    test "updates dietary_option in listing", %{conn: conn, dietary_option: dietary_option} do
      {:ok, index_live, _html} = live(conn, ~p"/dietary_options")

      assert index_live |> element("#dietary_options-#{dietary_option.id} a", "Edit") |> render_click() =~
               "Edit Dietary option"

      assert_patch(index_live, ~p"/dietary_options/#{dietary_option}/edit")

      assert index_live
             |> form("#dietary_option-form", dietary_option: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#dietary_option-form", dietary_option: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/dietary_options")

      html = render(index_live)
      assert html =~ "Dietary option updated successfully"
    end

    test "deletes dietary_option in listing", %{conn: conn, dietary_option: dietary_option} do
      {:ok, index_live, _html} = live(conn, ~p"/dietary_options")

      assert index_live |> element("#dietary_options-#{dietary_option.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#dietary_options-#{dietary_option.id}")
    end
  end

  describe "Show" do
    setup [:create_dietary_option]

    test "displays dietary_option", %{conn: conn, dietary_option: dietary_option} do
      {:ok, _show_live, html} = live(conn, ~p"/dietary_options/#{dietary_option}")

      assert html =~ "Show Dietary option"
    end

    test "updates dietary_option within modal", %{conn: conn, dietary_option: dietary_option} do
      {:ok, show_live, _html} = live(conn, ~p"/dietary_options/#{dietary_option}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Dietary option"

      assert_patch(show_live, ~p"/dietary_options/#{dietary_option}/show/edit")

      assert show_live
             |> form("#dietary_option-form", dietary_option: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#dietary_option-form", dietary_option: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/dietary_options/#{dietary_option}")

      html = render(show_live)
      assert html =~ "Dietary option updated successfully"
    end
  end
end
