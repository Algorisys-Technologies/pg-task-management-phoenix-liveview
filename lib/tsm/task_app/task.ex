defmodule Tsm.TaskApp.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tsm.Accounts.User

  schema "tasks" do
    field(:status, :string)
    field(:task_type, :string)
    # field :user_id, :id
    belongs_to(:users, User, foreign_key: :user_id)
    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:task_type, :status, :user_id])
    |> validate_required([:task_type, :status, :user_id])
  end
end
