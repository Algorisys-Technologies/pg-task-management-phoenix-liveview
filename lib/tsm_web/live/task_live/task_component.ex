defmodule TsmWeb.TaskLive.TaskComponent do
  use TsmWeb, :live_component

  def render(assigns) do
    ~H"""
    <tr>
        <td><%= @task.task_type %></td>
        <td><%= @task.status %></td>
        <td>
          <%= live_patch to: Routes.task_index_path(@socket, :edit, @task.id) do %>
            <span style="font-size:20px">&#69;&#100;&#105;&#116;</span>
          <% end %> &nbsp;&nbsp;&nbsp;
          <%= link to: "#", phx_click: "delete", phx_value_id: @task.id, data: [confirm: "Are you sure?"] do %>
            <span style="font-size:20px"> 🚮 </span>
          <% end %>
        </td>
      </tr>
    """
  end
end
