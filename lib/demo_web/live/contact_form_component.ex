defmodule DemoWeb.ContactFormComponent do
  use DemoWeb, :live_component

  def render(assigns) do
    ~H"""
    <div>
      <.form let={f} 
      for={@changeset}
      phx-target={@myself}
      phx-submit="send-email">
        <%= label f, :subject %>
        <%= text_input f, :subject %>
        <%= error_tag f, :subject %>

        <%= label f, :name %>
        <%= text_input f, :name %>
        <%= error_tag f, :name %>

        <%= label f, :email %>
        <%= email_input f, :email %>
        <%= error_tag f, :email %>

        <%= label f, :contact_number %>
        <%= text_input f, :contact_number %>
        <%= error_tag f, :contact_number %>

        <%= label f, :message %>
        <%= textarea f, :message %>
        <%= error_tag f, :message %>

        <div phx-hook="GoogleRecaptcha" id="captcha-placeholder" data-sitekey={Demo.GoogleRecaptcha.get_public_key()}></div>
        <%= if @show_recaptcha_error do %>
          <span class="invalid-feedback">
            You need to have ticked the checkbox. Please try again
          </span>
        <% end %>

        <%= submit "Submit", class: "button-primary" %>
      </.form>
    </div>
    """
  end

  def handle_event("send-email", %{"contact_schema" => contact_schema_attrs, "g-recaptcha-response" => g_recaptcha_response}, socket) do
    changeset =
      Demo.ContactSchema.changeset(%Demo.ContactSchema{}, contact_schema_attrs)
      |> Map.put(:action, :validate)

    # This line will give either false or true after verifying.
    # The response from google recaptcha returns a parameter called "success". This by default returns false if no `value` is found.
    verified = Demo.GoogleRecaptcha.verify(g_recaptcha_response) |> Map.get("success", false)

    cond do
      verified && changeset.valid? ->
        {:noreply,
        assign(socket, :show_recaptcha_error, false)
        |> push_patch(to: "/", replace: true)
        |> put_flash(:info, "Email sent")}
      
      !changeset.valid? && !verified ->
        {:noreply, assign(socket, changeset: changeset, show_recaptcha_error: true)}
      
      !verified ->
        {:noreply, assign(socket, changeset: changeset, show_recaptcha_error: true)}

      !changeset.valid? ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def mount(socket) do
    changeset = Demo.ContactSchema.changeset(%Demo.ContactSchema{}, %{})

    {:ok, 
    assign(socket, 
      changeset: changeset,
      show_recaptcha_error: false
    )}
  end
end
