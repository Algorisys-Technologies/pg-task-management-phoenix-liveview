defmodule Tsm.TaskAppFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tsm.TaskApp` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        status: "some status",
        task_type: "some task_type"
      })
      |> Tsm.TaskApp.create_task()

    task
  end
end
