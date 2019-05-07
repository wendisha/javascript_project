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
    if !Player.find_by_id(params[:contract][:player_id]).contracts.nil?
      if !Player.find_by_id(params[:contract][:player_id]).contracts.empty?
        if Player.find_by_id(params[:contract][:player_id]).contracts.in_effect.count > 0 && params[:contract][:status] == "in effect"
          redirect_to new_user_contract_path(User.find_by_id(session[:user_id]), error_message: "each player can only have one contract in effect at a time. please change the status of the previously in effect contract before adding a new in effect contract") and return
        end
      end
    end

    if params[:contract][:player_id].nil? || params[:contract][:agent_id].nil? || params[:contract][:club_id].nil? || params[:contract][:status].nil?
      redirect_to new_user_contract_path(error_message: "a contract must have a player, an agent, a club and a status")
    elsif params[:contract][:player_id].empty? || params[:contract][:agent_id].empty? || params[:contract][:club_id].empty? || params[:contract][:status].empty?
      redirect_to new_user_contract_path(error_message: "a contract must have a player, an agent, a club and a status")
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
    if !Player.find_by_id(params[:contract][:player_id]).contracts.nil?
      if !Player.find_by_id(params[:contract][:player_id]).contracts.empty?
        if Contract.find_by_id(params[:contract][:id]).status != params[:contract][:status]
          if Contract.find_by_id(params[:contract][:id]).status == "in effect"

          elsif Player.find_by_id(params[:contract][:player_id]).contracts.in_effect.count > 0 && params[:contract][:status] == "in effect"
            redirect_to edit_user_contract_path(error_message: "each player can only have one contract in effect at a time. please change the status of the previously in effect contract before adding a new in effect contract") and return
          end
        end
      end
    end

    if params[:contract][:player_id].nil? || params[:contract][:agent_id].nil? || params[:contract][:club_id].nil? || params[:contract][:status].nil?
      redirect_to edit_user_contract_path(error_message: "a contract must have a player, an agent, a club and a status")
    elsif params[:contract][:player_id].empty? || params[:contract][:agent_id].empty? || params[:contract][:club_id].empty? || params[:contract][:status].empty?
      redirect_to edit_user_contract_path(error_message: "a contract must have a player, an agent, a club and a status")
    else
      @contract = Contract.find_by_id(params[:contract][:id])
      @contract.update(contract_params)
      redirect_to user_contract_path(@contract.user, @contract)
    end
  end

  def destroy
    @contract = Contract.find_by(user_id: params[:user_id], id: params[:id])
    @contract.delete
    redirect_to user_contracts_path(User.find_by_id(session[:user_id]))
  end

  def contract_params
    params.require(:contract).permit(:length, :weekly_salary, :transfer_fee, :unusual_clauses, :status, :player_id, :club_id, :agent_id, :user_id)
  end

end
