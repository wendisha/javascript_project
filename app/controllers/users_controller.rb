class UsersController < ApplicationController

  def new
    already_logged_in
    @user = User.new
  end

  def create
    @user = User.new(name: params[:user][:name], password: params[:user][:password])
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'users/new'
    end
  end

  def show
    if_not_logged_in
    not_your_page_id_v
    if_error
    @user = User.find_by_id(params[:id])
  end

  def trophy
    contracts = Contract.where(user_id: session[:user_id])
    hash = {}
    @contracts = contracts.order(transfer_fee: :desc)
    binding.pry
    

  end
end
