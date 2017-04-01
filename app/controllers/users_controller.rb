class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    @stats = user.stats.all.order("date DESC").limit(7)
    @user = user
  end

end