class UsersController < ApplicationController

  def new
    already_logged_in
    if_error
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
      redirect_to new_user_path(error_message: "please select a different user name. that one is already in use")
    end
  end

  def show
    if_not_logged_in
    not_your_page_id_v
    if_error
    @user = User.find_by_id(params[:id])
  end


end
