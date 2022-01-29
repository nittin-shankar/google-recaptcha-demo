defmodule Demo.GoogleRecaptcha do
  use Tesla

  plug {Tesla.Middleware.BaseUrl, "https://www.google.com"}
  plug Tesla.Middleware.FormUrlencoded
  plug Tesla.Middleware.JSON

  def verify(resp) do
    request_body = %{secret: get_secret(), response: resp}
    {:ok, %Tesla.Env{body: body}} = post("/recaptcha/api/siteverify", request_body)
    body
  end

  def get_public_key() do
    config = Application.get_env(:demo, :google_recaptcha)
    config[:public_key]
  end  

  # Take a note of this function
  defp get_secret() do 
    config = Application.get_env(:demo, :google_recaptcha)
    config[:secret]
  end
end
