class SubmitsController < ApplicationController
	def show
		@call = Budget.new
		@buxfer= @call.buxfer(ENV["email"],ENV["password"])

	end
end
