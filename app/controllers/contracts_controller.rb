class ContractsController < ApplicationController
  before_action :authorization, except: [:create, :update]

  def index
    @contracts = Contract.where(user_id: session[:user_id])
  end

  def show
    if session[:user_id] != Contract.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    @contract = Contract.find_by_id(params[:id])
  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    if @contract.save
      redirect_to user_contract_path(@contract.user, @contract)
    else
      render 'contracts/new'
    end
  end

  def edit
    if session[:user_id] != Contract.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    @contract = Contract.find_by_id(params[:id])
    @user_id = session[:user_id]
  end

  def update
    @contract = Contract.find_by(user_id: params[:contract][:user_id], id: params[:contract][:id])
    if @contract.update(contract_params)
      redirect_to user_contract_path(@contract.user, @contract)
    else
      render 'contracts/edit'
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
