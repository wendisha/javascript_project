class AgentsController < ApplicationController

  def index
    @agents = Agent.all
  end

  def show
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
