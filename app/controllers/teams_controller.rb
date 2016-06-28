class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.manager_id = 1
    if @team.save
      redirect_to @team
    else
      render 'new'
    end
  end

  def show
    @team = Team.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def team_params
    params.require(:team).permit(:name, :sport_id, :min_players, :ideal_players, :min_females)
  end

end
