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

  end

  def edit
    @club = Club.find_by_id(params[:id])
  end

  def update

  end 

end
