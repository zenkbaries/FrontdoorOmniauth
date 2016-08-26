class SessionsController < ApplicationController

	def create
		auth = request.env["omniauth.auth"]
		user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
		session[:user_id] = user.id
		@auth_hash = auth
		@info_hash = auth["info"]
		@cred_hash = auth["credentials"]
		@extra_hash = auth["extra"]
		@raw_hash = auth["extra"]["raw_info"]
		# redirect_to root_url, :notice => "Signed in!"
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path, notice: "Signed out!"
	end
end
