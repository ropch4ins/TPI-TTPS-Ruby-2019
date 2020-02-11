class UsersController < ApplicationController
	
	before_action :validate_params, only: [:create]
	
  	# POST /usuarios
	def create
		@user = User.new(request_params)
		if @user.save
			render jsonapi: @user, status: :created
		else
			render jsonapi_errors: @user.errors
		end
	end

	private

	def validate_params
		@request = CreateUserRequest.new request_params
		render jsonapi_errors: @request.errors, status: :bad_request if !@request.valid?
	end
end