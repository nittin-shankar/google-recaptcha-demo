defmodule DemoWeb.PageLive do
  use DemoWeb, :live_view

  def render(assigns) do
    ~H"""
    <section>
      <div class="phx-hero">
        <h1>Welcome to this demo site!</h1>
        <p>You'll see the implementaion of Google reCAPTCHA with live view this page</p>
      </div>
    </section>
    <section>
      <.live_component module={DemoWeb.ContactFormComponent} id="contact-form-component" />
    </section>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(_params, _session, socket) do
    {:noreply, socket}
  end
end