class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])  # For testing purposes.  Erase this line and use line below before deploying
    # @user = current_user    USE THIS LINE AND DELETE LINE ABOVE BEFORE DEPLOYING
    authorize @user
  end
end
