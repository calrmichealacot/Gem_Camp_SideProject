class Client::ProfilesController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  def show; end

  def edit
    @user = current_client_user
  end

  def update
    @user = current_client_user
    if @user.update(user_params)
      flash[:notice] = 'Post updated successfully'
      redirect_to client_profiles_show_path
    else
      render :edit, status: :unprocessable_entity

    end
  end

  private

  def set_user
    @user = current_client_user
  end

  def user_params
    params.require(:user).permit(:image, :email, :phone_number) #:user_address,:username)
  end
end

