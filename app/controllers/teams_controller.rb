class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.manager = current_user
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
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])

    if @team.update(team_params)
      redirect_to team_path(@team)
    else
      render "edit"
    end
  end

  def destroy
  end

  private
  def team_params
    params.require(:team).permit(:name, :sport_id, :min_players, :ideal_players, :min_females)
  end

end
