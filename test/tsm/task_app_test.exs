defmodule Tsm.TaskAppTest do
  use Tsm.DataCase

  alias Tsm.TaskApp

  describe "tasks" do
    alias Tsm.TaskApp.Task

    import Tsm.TaskAppFixtures

    @invalid_attrs %{status: nil, task_type: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert TaskApp.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert TaskApp.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{status: "some status", task_type: "some task_type"}

      assert {:ok, %Task{} = task} = TaskApp.create_task(valid_attrs)
      assert task.status == "some status"
      assert task.task_type == "some task_type"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskApp.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{status: "some updated status", task_type: "some updated task_type"}

      assert {:ok, %Task{} = task} = TaskApp.update_task(task, update_attrs)
      assert task.status == "some updated status"
      assert task.task_type == "some updated task_type"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskApp.update_task(task, @invalid_attrs)
      assert task == TaskApp.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = TaskApp.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> TaskApp.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = TaskApp.change_task(task)
    end
  end
end
