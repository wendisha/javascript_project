class ContractsController < ApplicationController

  def index
    if session[:user_id].nil?
      redirect_to login_path(error_message: "please log in")
    end
    if session[:user_id] != params[:user_id]
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your page")
    end

    @contracts = Contract.all
  end

  def show
    if session[:user_id].nil?
      redirect_to login_path(error_message: "please log in")
    end
    if session[:user_id] != params[:user_id]
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your page")
    end
    if session[:user_id] != Contract.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your page")
    end

    @contract = Contract.find_by_id(params[:id])
  end

  def new

    @contract = Contract.new
  end

  def create
    @contract = Contract.create(contract_params)
  end

  def edit
    @contract = Contract.find_by_id(params[:id])
  end

  def update

  end

  def destroy

  end

  def contract_params
    params.require(:contract).permit(:length, :weekly_salary, :transfer_fee, :unusual_clauses, :status, :futbolista_id, :club_id, :agent_id)
  end

end
