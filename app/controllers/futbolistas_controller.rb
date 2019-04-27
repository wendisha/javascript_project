class FutbolistasController < ApplicationController

  def index
    @futbolistas = Futbolista.all
  end

  def show
    @futbolista = Futbolista.find_by_id(params[:id])
  end

  def new
    @futbolista = Futbolista.new
  end

  def create
    @futbolista = Futbolista.create(futbolista_params)
  end

  def edit
    @futbolista = Futbolista.find_by_id(params[:id])
  end

  def update

  end

  def destroy

  end

  def futbolista_params
    params.require(:futbolista).permit(:name, :country_of_origin, :position, :agent_id, :club_id, :contract_id)
  end

end
