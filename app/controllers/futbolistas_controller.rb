class FutbolistasController < ApplicationController

  def index
    if_not_logged_in
    not_your_page_user_id_v
    @futbolistas = Futbolista.all
  end

  def show
    if_not_logged_in
    not_your_page_user_id_v
    if session[:user_id] != Futbolista.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
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
