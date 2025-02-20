defmodule CsvExports do
  alias DiabetesV1.Repo
  import Ecto.Adapters.SQL

  def export_all_tables do
    export_dir = "/home/andy/Desktop/pgadmin_csv"
    File.mkdir_p!(export_dir)

    tables_query = "SELECT tablename FROM pg_tables WHERE schemaname = 'public';"
    {:ok, result} = query(Repo, tables_query, [])
    all_tables = Enum.map(result.rows, fn [table_name] -> table_name end)

    exclude_tables = ["schema_migrations", "users_tokens"]
    tables = all_tables -- exclude_tables

    for table <- tables do
      IO.write("Export #{table}? (y/n): ")
      response = IO.gets("") |> String.trim() |> String.downcase()

      if response == "y" do
        filename = Path.join(export_dir, "#{table}.csv")

        IO.puts("Exporting #{table} to #{filename}...")

        try do
          {:ok, file} = File.open(filename, [:write])

          try do
            stream = stream(Repo, "COPY (SELECT * FROM #{table}) TO STDOUT WITH CSV HEADER", [])

            Repo.transaction(fn ->
              Enum.each(stream, fn
                %Postgrex.Result{rows: rows} ->  # ✅ Extract the rows properly
                  Enum.each(rows, fn row ->
                    IO.write(file, String.trim_trailing(row) <> "\n")  # Trim existing newlines
                  end)
                row when is_binary(row) ->
                  IO.write(file, String.trim_trailing(row) <> "\n")
              end)
            end)

            IO.puts("✅ Exported #{table} successfully!")
          after
            File.close(file)
          end
        rescue
          e -> IO.puts("❌ Failed to export #{table}: #{Exception.message(e)}")
        end
      else
        IO.puts("⏭ Skipping #{table}.")
      end
    end
  end
end

# Run the function
CsvExports.export_all_tables()
