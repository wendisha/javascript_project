class ContractsController < ApplicationController

  def index

  end

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.create(contract_params)
  end

  def show
    @contract = Contract.find_by_id(params[:id])
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
