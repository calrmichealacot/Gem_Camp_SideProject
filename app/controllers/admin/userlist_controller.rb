class Admin::UserlistController < ApplicationController
  # before_action :authenticate_user!

  def index
    @users = User.client
  end
end