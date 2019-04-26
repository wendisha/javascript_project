class ClubsController < ApplicationController

  def index
    @clubs = Club.all
  end

  def show
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
