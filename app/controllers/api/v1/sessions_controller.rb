class Api::V1::SessionsController < Devise::SessionsController
	before_action :valid_token , only: :destroy
	skip_before_action :verify_signed_out_user , only: :destroy

	# signin user
	def create
		@user = User.find_by(email: params[:email])
		
		if @user
			if @user.valid_password?(params[:password])
				sign_in "user", @user
				json_response "LoggedIn Succcessfully!",true,{user: @user},:ok
			else
				json_response "Unauthorized",false,{},:unauthorized
			end
		else
			message = "Can't get user!"
			is_success = false
			data = {}
			status = :bad_request	
			json_response message,is_success,data,status
		end
	end

	# logout
	def destroy
		sign_out @user
		@user.generate_new_authentication_token
		json_response "Logout Succcessfully",true,{},:ok 
	end	


	private
	def valid_token
		@user = User.find_by authentication_token: request.headers["AUTH-TOKEN"]
		if @user
			return @user
		else
			json_response "Invalid Token",false,{},:failed_dependency
		end	
	end

end