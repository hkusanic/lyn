defmodule Lyn.Object do
  use Lyn.Web, :model

  schema "objects" do
    field :sort_order, :integer
    field :parent_id, :integer
    field :thread_id, :integer
    field :nesting, :integer
    field :cache_time, :integer
    field :is_published, :boolean, default: false
    field :is_show_on_site_map, :boolean, default: false
    field :is_show_in_menu, :boolean, default: false
    field :path, :string
    field :url, :string
    field :full_path, :string

    belongs_to :object_type, Lyn.ObjectType
    belongs_to :site, Lyn.Site
    has_many :children, Lyn.Object, foreign_key: :parent_id

    timestamps
  end

  def admin_fields do
    [
      id: %{
        label: "id",
        type: :integer
      },
      sort_order: %{
        label: "sort_order",
        type: :integer
      }
    ]
  end

  @required_fields ~w(sort_order parent_id thread_id site_id object_type_id nesting cache_time is_published is_show_on_site_map is_show_in_menu path url full_path)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
