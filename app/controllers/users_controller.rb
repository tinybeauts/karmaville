class UsersController < ApplicationController
  def index
    @users = User.by_karma(params[:page])
  end

end
