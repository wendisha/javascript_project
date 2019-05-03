class ContractsController < ApplicationController

  def index
    if_not_logged_in
    not_your_page_user_id_v
    @contracts = Contract.where(user_id: session[:user_id])
  end

  def show
    if_not_logged_in
    not_your_page_user_id_v
    if session[:user_id] != Contract.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    @contract = Contract.find_by_id(params[:id])
  end

  def new
    if_not_logged_in
    not_your_page_user_id_v
    if_error
    @contract = Contract.new
    @user_id = session[:user_id]
  end

  def create
    if params[:contract][:player_id].empty? || params[:contract][:agent_id].empty? || params[:contract][:club_id].empty? || params[:contract][:status].empty?
      redirect_to new_user_contract_path(error_message: "a contract must have a player, an agent, a club and a status")
    elsif Contract.find_by(player_id: params[:contract][:player_id], club_id: params[:contract][:club_id])
      redirect_to new_user_contract_path(error_message: "you already have a contract between that player and that club")
    else
      @contract = Contract.create(contract_params)
      redirect_to user_contract_path(@contract.user, @contract)
    end
  end

  def edit
    if_not_logged_in
    not_your_page_user_id_v
    if session[:user_id] != Contract.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    if_error
    @contract = Contract.find_by_id(params[:id])
    @user_id = session[:user_id]
  end

  def update
    if params[:contract][:player_id].empty? || params[:contract][:agent_id].empty? || params[:contract][:club_id].empty? || params[:contract][:status].empty?
      redirect_to edit_user_contract_path(error_message: "a contract must have a player, an agent, a club and a status")
    elsif Contract.where(user_id: params[:contract][:user_id], player_id: params[:contract][:player_id], club_id: params[:contract][:club_id]).count > 1
      redirect_to edit_user_contract_path(error_message: "you already have a contract between that player and that club")
    else
      @contract = Contract.find_by(user_id: params[:contract][:user_id], player_id: params[:contract][:player_id], club_id: params[:contract][:club_id])
      Contract.update(contract_params)
      redirect_to user_contract_path(@contract.user, @contract)
    end
  end

  def destroy
  end

  def contract_params
    params.require(:contract).permit(:length, :weekly_salary, :transfer_fee, :unusual_clauses, :status, :player_id, :club_id, :agent_id, :user_id)
  end

end
