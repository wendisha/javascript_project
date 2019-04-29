class ClubsController < ApplicationController

  def index
    if_not_logged_in
    if_not_your_page_user_id_v

    @clubs = Club.all
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
    @club = Club.new
  end

  def create
    @club = Club.create(club_params)
  end

  def edit
    @club = Club.find_by_id(params[:id])
  end

  def update

  end

  def club_params
    params.require(:club).permit(:name, :city, :nation, :league_division)
  end

end
