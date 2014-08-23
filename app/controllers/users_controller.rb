class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]
  
  def set_user
    @user = User.find_by(username: params[:id])
  end
  
  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(params.require(:user).permit(:username, :password, :time_zone))
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You've registered a new user"
      redirect_to root_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(:username, :password))
      flash[:notice] = "Profile updated"
      redirect_to root_path
    else
      render :edit
    end
  end
end
