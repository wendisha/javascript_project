class ClubsController < ApplicationController

  def index
    if session[:user_id].nil?
      redirect_to login_path(error_message: "please log in")
    end
    if session[:user_id] != params[:user_id]
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your page")
    end

    @clubs = Club.all
  end

  def show
    if session[:user_id].nil?
      redirect_to login_path(error_message: "please log in")
    end
    if session[:user_id] != params[:user_id]
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your page")
    end
    if session[:user_id] != Club.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your page")
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
