class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.players.each do |player|
      Rsvp.create(game: @game, responder: player)
    end
    if @game.save
      redirect_to @game
    else
      render 'new'
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def game_params
    params.require(:game).permit(:date, :time, :location, :team_id)
  end

end
