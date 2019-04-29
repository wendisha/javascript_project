class AgentsController < ApplicationController

  def index
    if session[:user_id].nil?
      redirect_to login_path(error_message: "please log in")
    end
    if session[:user_id] != params[:user_id]
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your page")
    end

    @agents = Agent.all
  end

  def show
    if session[:user_id].nil?
      redirect_to login_path(error_message: "please log in")
    end
    if session[:user_id] != params[:user_id]
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your page")
    end
    if session[:user_id] != Agent.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your page")
    end
    
    @agent = Agent.find_by_id(params[:id])
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.create(agent_params)
  end

  def edit
    @agent = Agent.find_by_id(params[:id])
  end

  def update

  end

  def destroy

  end

  def agent_params
    params.require(:agent).permit(:name, :country_of_origin, futbolista_attributes: [:id])
  end

end
