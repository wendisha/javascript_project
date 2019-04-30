class PlayersController < ApplicationController

  def index
    if_not_logged_in
    not_your_page_user_id_v
    @players = Player.all
  end

  def show
    if_not_logged_in
    not_your_page_user_id_v
    if session[:user_id] != Player.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    @player = Player.find_by_id(params[:id])
  end

  def new
    if_not_logged_in
    not_your_page_user_id_v
    if_error
    @player = Player.new
    @user_id = params[:user_id]
  end

  def create
    if params[:player][:name].empty?
      redirect_to new_user_player_path(error_message: "a player must have a name")
    elsif Player.find_by(user_id: params[:player][:user_id], name: params[:player][:name])
      redirect_to new_user_player_path(error_message: "you already have a player by that name")
    else
      @player = Player.create(player_params)
      redirect_to user_player_path(@player.user, @player)
    end
  end

  def edit
    if_not_logged_in
    not_your_page_user_id_v
    if session[:user_id] != Player.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    if_error
    @player = Player.find_by_id(params[:id])
  end

  def update
    if params[:player][:name].empty?
      redirect_to edit_user_player_path(User.find_by_id(params[:user_id]), Player.find_by_id(params[:id]), error_message: "a player must have a name")
    elsif Player.find_by(user_id: params[:player][:user_id], name: params[:player][:name]).count > 1
      redirect_to edit_user_player_path(User.find_by_id(params[:user_id]), Player.find_by_id(params[:id]), error_message: "you have another player by that name")
    else
      @player = Player.find_by(user_id: params[:player][:user_id], name: params[:player][:name])
      @player.update(player_params)
      redirect_to user_player_path(@player.user, @player)
    end
  end

  def destroy

  end

  def player_params
    params.require(:player).permit(:name, :country_of_origin, :position, :agent_id, :club_id, :contract_id, :user_id, :id)
  end

end
