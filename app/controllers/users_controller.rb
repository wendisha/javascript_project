class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    if !User.find_by(name: params[:user][:name])
      @user = User.create(name: params[:user][:name], password: params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to login_path
    end
  end

  def show
    if params[:error_message]
      @error_message = params[:error_message]
    end
    if !session[:user_id].nil?
      if params[:id].to_i == session[:user_id]
        @user = User.find_by_id(params[:id])
      else
        redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your user page.")
      end
    else
      redirect_to login_path(error_message: "please login")
    end
  end


end
