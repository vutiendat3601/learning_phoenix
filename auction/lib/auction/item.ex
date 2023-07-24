defmodule Auction.Item do
  # defstruct id: 0, title: "Item", description: "Description", ends_at: ~N[2023-07-24 09:03:00]
  import Ecto.Changeset
  use Ecto.Schema

  schema "items" do
    field :title, :string
    field :description, :string
    field :ends_at, :utc_datetime
    timestamps()
  end

  def changeset(item, params \\ %{}) do
    # Only aloow update {title, description, ends_at}, source from params
    item
    |> cast(params, [:title, :description, :ends_at])
    |> validate_required(:title)
    |> validate_length(:title, min: 3)
    |> validate_length(:description, max: 200)
    |> validate_change(:ends_at, &validate/2)
  end

  defp validate(:ends_at, ends_at_date) do
    case DateTime.compare(ends_at_date, DateTime.utc_now()) do
      # <:gt | :lt | :eq>
      :lt -> [ends_at: "ends_at can't be in the past"]
      _ -> []
    end
  end
end
