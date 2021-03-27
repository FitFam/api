defmodule FitFam.UserEmail do
	use Phoenix.Swoosh, view: FitFamWeb.EmailView, layout: {FitFamWeb.LayoutView, :email}

	def welcome(user) do
		new()
		|> to({user.name, user.email})
		|> from({"FitFam", "andy@fitfam.me"})
		|> subject("Thanks for signing up for FitFam!")
		|> render_body("welcome.html", %{name: user.name, username: user.username, token: user.token})
	end
end
