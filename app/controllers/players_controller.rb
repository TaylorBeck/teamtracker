class PlayersController < ApplicationController

  def index

  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      redirect_to teams_path
    else
      render "new"
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

  def player_params
    params.require(:player).permit(:name, :gender, :phone_number)
  end

end
