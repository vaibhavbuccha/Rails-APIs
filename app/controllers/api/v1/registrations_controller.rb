class Api::V1::RegistrationsController < Devise::RegistrationsController
	before_action :ensure_params_exits , only: :create
	# signup function
	def create
		user = User.new(create_params)
		if user.save
			message = "Signup successfully"
			is_success = true
			data = {
					user: user
				}
			status = :ok	
			json_response message,is_success,data,status
			
		else
			message = "Somthing wents wrong"
			is_success = false
			data = {}
			status = :unprocessable_entity	
			json_response message,is_success,data,status
		end
	end


	private 
	def create_params
		params.require(:user).permit(:email,:password,:password_confirmation)
	end

	def ensure_params_exits
		return if params[:user].present?
		message = "Somthing is missing"
		is_success = false
		data = {}
		status = :bad_request	
		json_response message,is_success,data,status
	end

end