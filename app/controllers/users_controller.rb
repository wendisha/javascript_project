class UsersController < ApplicationController

  def new
    if params[:error_message]
      @error_message = params[:error_message]
    end
    @user = User.new
  end

  def create
    if params[:user][:name].empty? || params[:user][:password].empty?
      redirect_to new_user_path(error_message: "please enter a username and a password")
    elsif !User.find_by(name: params[:user][:name])
      @user = User.create(name: params[:user][:name], password: params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_user_path(error_message: "please select a different user name. that one is taken")
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
