class FutbolistasController < ApplicationController

  def index
    if session[:user_id].nil?
      redirect_to login_path(error_message: "please log in")
    end
    if session[:user_id] != params[:user_id]
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your page")
    end

    @futbolistas = Futbolista.all
  end

  def show
    if session[:user_id].nil?
      redirect_to login_path(error_message: "please log in")
    end
    if session[:user_id] != params[:user_id]
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your page")
    end
    if session[:user_id] != Futbolista.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your page")
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
