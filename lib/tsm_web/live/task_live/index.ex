defmodule TsmWeb.TaskLive.Index do
  use TsmWeb, :live_view

  alias Tsm.TaskApp
  alias Tsm.TaskApp.Task

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    if(connected?(socket), do: TaskApp.subscribe())
    {:ok, assign(socket, :tasks, list_of_task_by_user_id(socket)), temporary_assigns: [tasks: []]}
  end

  defp list_of_task_by_user_id(socket) do
    TaskApp.task_by_user(socket.assigns.current_user.id)
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Task")
    |> assign(:task, TaskApp.get_task!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Task")
    |> assign(:task, %Task{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Tasks")
    |> assign(:task, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    task = TaskApp.get_task!(id)
    {:ok, _} = TaskApp.delete_task(task)
    {:noreply, assign(socket, :tasks, list_of_task_by_user_id(socket))}
  end

  @impl true
  def handle_info({:task_created, task}, socket) do
    {:noreply, update(socket, :tasks, fn tasks -> [task | tasks] end)}
  end

  def handle_info({:task_updated, task}, socket) do
    {:noreply, update(socket, :tasks, fn tasks -> [task | tasks] end)}
  end

  def handle_info({:task_deleted, task}, socket) do
    {:noreply, update(socket, :tasks, fn tasks -> task.id != tasks.id end)}
  end

  # def handle_info({:task_deleted, task}, socket) do
  #   {:noreply, update(socket, :tasks, list_tasks())}
  # end

  defp list_tasks do
    TaskApp.list_tasks()
  end
end
