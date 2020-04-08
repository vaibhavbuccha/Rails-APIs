module Authenticate

	def current_user
		auth_token = request.header["AUTH-TOKEN"]
		return unless auth_token
		@current_user = User.find_by authentication_token: auth_token
	end

	def  authentication_with_token!
		return if current_user
		json_response "Unauthenticated",false,{},:unauthorized 
	end
end