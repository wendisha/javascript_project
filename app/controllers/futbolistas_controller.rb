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
    if_not_logged_in
    not_your_page_user_id_v
    if_error
    @futbolista = Futbolista.new
    @user_id = params[:user_id]
  end

  def create
    if params[:futbolista][:name].empty?
      redirect_to new_user_futbolista_path(error_message: "a futbolista must have a name")
    elsif Futbolista.find_by(user_id: params[:futbolista][:user_id], name: params[:futbolista][:name])
      redirect_to new_user_futbolista_path(error_message: "you already have a futbolista by that name")
    else
      @futbolista = Futbolista.create(futbolista_params)
      redirect_to user_futbolista_path(@futbolista.user, @futbolista)
    end
  end

  def edit
    if_not_logged_in
    not_your_page_user_id_v
    if session[:user_id] != Futbolista.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    if_error
    @futbolista = Futbolista.find_by_id(params[:id])
  end

  def update
    if params[:futbolista][:name].empty?
      redirect_to edit_user_futbolista_path(User.find_by_id(params[:user_id]), Futbolista.find_by_id(params[:id]), error_message: "a futbolista must have a name")
    elsif Futbolista.find_by(user_id: params[:futbolista][:user_id], name: params[:futbolista][:name]).count > 1
      redirect_to edit_user_futbolista_path(User.find_by_id(params[:user_id]), Futbolista.find_by_id(params[:id]), error_message: "you have another futbolista by that name")
    else
      @futbolista = Futbolista.find_by(user_id: params[:futbolista][:user_id], name: params[:futbolista][:name])
      @futbolista.update(futbolista_params)
      redirect_to user_futbolista_path(@futbolista.user, @futbolista)
    end
  end

  def destroy

  end

  def futbolista_params
    params.require(:futbolista).permit(:name, :country_of_origin, :position, :agent_id, :club_id, :contract_id, :user_id, :id)
  end

end
