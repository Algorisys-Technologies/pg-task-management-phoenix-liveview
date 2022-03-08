defmodule Tsm.TaskApp do
  @moduledoc """
  The TaskApp context.
  """

  import Ecto.Query, warn: false
  alias Tsm.Repo

  alias Tsm.TaskApp.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(from(t in Task, order_by: [desc: t.id]))
  end

  def task_by_user(id) do
    # query = from "tasks", where: [user_id: ^id],
    #     select: [:id, :user_id, :status, :task_type]

    query = from(t in Task, where: [user_id: ^id], order_by: [desc: t.id])
    Repo.all(query)
  end

  # def list_tasks do
  #   Repo.get_by(Task, socket.assigns.current_user_id)
  # end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id)

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:task_created)
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
    |> broadcast(:task_updated)
  end

  @doc """
  Deletes a task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
    |> broadcast(:task_deleted)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(Tsm.PubSub, "tasks")
  end

  defp broadcast({:error, _reason} = error, _event), do: error

  defp broadcast({:ok, task}, event) do
    Phoenix.PubSub.broadcast(Tsm.PubSub, "tasks", {event, task})
    {:ok, task}
  end
end
