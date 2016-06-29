class TeamPlayerDetailsController < ApplicationController

  def index
  end

  def new
    @team = Team.find(params[:team_id])
    @team_player_detail = TeamPlayerDetail.new
  end

  def create
    # find team from params
    @team = Team.find(params[:team_id])
    # assign key_position from form checkbox
    key_position = team_player_detail_params.fetch(:key_position)
    params[:team_player_detail][:key_position] = key_position ? true : false
    # create new team_player_detail object
    @team_player_detail = TeamPlayerDetail.new(team_player_detail_params)
    # assign correct team to detail
    @team_player_detail.team_id = params[:team_id]
    # save new object to team
    if @team.team_player_details << @team_player_detail
      redirect_to @team
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def team_player_detail_params
    params.require(:team_player_detail).permit(:key_position, :skill_level, :player_id, :team_id)
  end

end
