class UsersController < ApplicationController
  def index
    @users = User.includes([:posts]).all
  end

  def show
    @user = User.includes(posts: %i[comments likes]).find(params[:id])
  end

  def destroy
    @user = User.find(params[:id]).destroy
    redirect_to users_path, notice: 'User deleted successfully'
  end
end
