class PlayersController < ApplicationController

  def index
    authorization
    @players = Player.where(user_id: session[:user_id])
  end

  def show
    authorization
    if session[:user_id] != Player.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    @player = Player.find_by_id(params[:id])
  end

  def new
    authorization
    @player = Player.new
  end

  def create
      @player = Player.new(player_params)
      if @player.save
        redirect_to user_player_path(@player.user, @player)
      else
        render 'players/new'
      end
  end

  def edit
    authorization
    if session[:user_id] != Player.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    if_error
    @player = Player.find_by_id(params[:id])
  end

  def update
    @player = Player.find_by(user_id: params[:player][:user_id], id: params[:player][:id])
    if @player.update(player_params)
      redirect_to user_player_path(@player.user, @player)
    else
      render 'players/edit'
    end
  end

  def destroy
    @player = Player.find_by(user_id: params[:user_id], id: params[:id])
    @player.delete
    redirect_to user_players_path(User.find_by_id(session[:user_id]))
  end

  def player_params
    params.require(:player).permit(:name, :country_of_origin, :position, :agent_id, :club_id, :contract_id, :user_id, :id)
  end

end
