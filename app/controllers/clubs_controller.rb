class ClubsController < ApplicationController

  def index
    if_not_logged_in
    not_your_page_user_id_v

    @clubs = Club.where(user_id: session[:user_id])
  end

  def show
    if_not_logged_in
    not_your_page_user_id_v
    if session[:user_id] != Club.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    @club = Club.find_by_id(params[:id])
  end

  def new
    if_not_logged_in
    not_your_page_user_id_v
    if_error
    @club = Club.new
    @user_id = params[:user_id]
  end

  def create
    if params[:club][:name].empty? || params[:club][:city].empty? || params[:club][:nation].empty? || params[:club][:league_division].empty?
      redirect_to new_user_club_path(error_message: "a club must have a name, city, nation, and league/division")
    elsif Club.find_by(user_id: params[:club][:user_id], name: params[:club][:name])
      redirect_to new_user_club_path(error_message: "you already have a club by that name")
    else
      @club = Club.create(club_params)
      redirect_to user_club_path(@club.user, @club)
    end
  end

  def edit
    if_not_logged_in
    not_your_page_user_id_v
    if session[:user_id] != Club.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    if_error
    @club = Club.find_by_id(params[:id])
  end

  def update
    if params[:club][:name].empty? || params[:club][:city].empty? || params[:club][:nation].empty? || params[:club][:league_division].empty?
      redirect_to edit_user_club_path(User.find_by_id(params[:user_id]), Club.find_by_id(params[:id]), error_message: "a club must have a name, city, nation and league/division")
    elsif Club.find_by(user_id: params[:club][:user_id], name: params[:club][:name]).count > 1
      redirect_to edit_user_club_path(User.find_by_id(params[:user_id]), Club.find_by_id(params[:id]), error_message: "you have another club by that name")
    else
      @club = Club.find_by(user_id: params[:club][:user_id], name: params[:club][:name])
      @club.update(club_params)
      redirect_to user_club_path(@club.user, @club)
    end
  end

  def destroy
  end

  def club_params
    params.require(:club).permit(:name, :city, :nation, :league_division, :user_id, :id)
  end

end
