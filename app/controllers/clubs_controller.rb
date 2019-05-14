class ClubsController < ApplicationController
  before_action :authorization, except: [:create, :update]

  def index
    @clubs = Club.where(user_id: session[:user_id])
  end

  def show
    if session[:user_id] != Club.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    @club = Club.find_by_id(params[:id])
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.new(club_params)
    if @club.save
      redirect_to user_club_path(@club.user, @club)
    else
      render 'clubs/new'
    end
  end

  def edit
    if session[:user_id] != Club.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    @club = Club.find_by_id(params[:id])
  end

  def update
    @club = Club.find_by(user_id: params[:club][:user_id], id: params[:club][:id])
    if @club.update(club_params)
      redirect_to user_club_path(@club.user, @club)
    else
      render 'clubs/edit'
    end
  end

  def destroy
    @club = Club.find_by(user_id: params[:user_id], id: params[:id])
    @club.delete
    redirect_to user_clubs_path(User.find_by_id(session[:user_id]))
  end

  def club_params
    params.require(:club).permit(:name, :city, :nation, :league_division, :user_id, :id)
  end

end
