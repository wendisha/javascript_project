class AgentsController < ApplicationController

  def index
    if_not_logged_in
    not_your_page_user_id_v
    @agents = Agent.where(user_id: session[:user_id])
  end

  def show
    if_not_logged_in
    not_your_page_user_id_v
    if session[:user_id] != Agent.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    @agent = Agent.find_by_id(params[:id])
  end

  def new
    if_not_logged_in
    not_your_page_user_id_v
    if_error
    @agent = Agent.new
    @user_id = params[:user_id]
  end

  def create
    if params[:agent][:name].empty?
      redirect_to new_user_agent_path(error_message: "an agent must have a name")
    elsif Agent.find_by(user_id: params[:agent][:user_id], name: params[:agent][:name])
      redirect_to new_user_agent_path(error_message: "you already have an agent by that name")
    else
      @agent = Agent.create(agent_params)
      redirect_to user_agent_path(@agent.user, @agent)
    end
  end

  def edit
    if_not_logged_in
    not_your_page_user_id_v
    if session[:user_id] != Agent.find_by_id(params[:id]).user.id
      redirect_to user_path(User.find_by_id(session[:user_id]), error_message: "that is not your data")
    end
    if_error
    @agent = Agent.find_by_id(params[:id])
  end

  def update
    if params[:agent][:name].empty?
      redirect_to edit_user_agent_path(User.find_by_id(params[:user_id]), Agent.find_by_id(params[:id]), error_message: "an agent must have a name")
    elsif Agent.find_by(user_id: params[:agent][:user_id], name: params[:agent][:name]).count > 1
      redirect_to edit_user_agent_path(User.find_by_id(params[:user_id]), Agent.find_by_id(params[:id]), error_message: "you have another agent by that name")
    else
      @agent = Agent.find_by(user_id: params[:agent][:user_id], name: params[:agent][:name])
      @agent.update(agent_params)
      redirect_to user_agent_path(@agent.user, @agent)
    end
  end

  def destroy

  end

  def agent_params
    params.require(:agent).permit(:name, :country_of_origin, :user_id, :id)
  end

end
