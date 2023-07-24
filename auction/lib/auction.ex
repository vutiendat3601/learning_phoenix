defmodule Auction do
  @moduledoc """
  Auction keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias Auction.{Item}

  @repo Auction.Repo

  def list_items do
    @repo.all(Item)
  end

  def get_item(id) do
    @repo.get!(Item, id)
  end

  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end

  def insert_item(attrs) do
    Auction.Item
    # Changes a map to a struct based on the arguments provided.
    |> struct(attrs)
    |> @repo.insert()
  end

  def delete_item(%Item{} = item), do: @repo.delete(item)

  def update_item(%Item{} = item, changeset),
    do: Item.changeset(item, changeset) |> @repo.update
end
