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
    # create new team_player_detail object
    @team_player_detail = TeamPlayerDetail.new(team_player_detail_params)

    # save new object to team

    puts "IAM BEFORE THE CONDITIONAL"
    if @team.team_player_details << @team_player_detail
      #add RSVPs for player to all games for this team
      puts "BEFORE RSVPS"
      @team_player_detail.team.games.each do |game|
        puts "Create RSVPS!!"
        Rsvp.create(responder: @team_player_detail.player, game: game, response: "none")
      end
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
