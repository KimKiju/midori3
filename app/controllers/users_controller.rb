class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    @stat_all = user.stats.all
    @stats = user.stats.order("date DESC").limit(7)
    @stat_chart = user.stats.order("created_at DESC").limit(7)
    @user = user
  end

end
