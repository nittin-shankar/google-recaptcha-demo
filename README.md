# Demo
This phoenix app is just a simple demo for implementing Google reCAPTCHA v2.
The files to take note of are building a similar implementation are:
1. `lib/mix.exs`
2. `config/dev.secret.exs`
3. `assets/app.js`
4. `lib/demo_web/live/contact_form_component.ex`

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser. You can see that there is a dummy form with the reCAPTCHA checkbox.
