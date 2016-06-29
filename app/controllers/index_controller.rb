class GamesController < ApplicationController
  def index
    @users = User.all
  end
end
