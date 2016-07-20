class UsersController < ApplicationController
  before_filter :require_login, only: [:manage]


  def index
  end
  # GET
  def register
    render 'users/new'
  end

  # POST
  def create
    @user = User.create(user_params)

    if @user.valid?
      redirect_to '/login'
    else
      @errors = @user.errors.full_messages
      render 'users/new'
    end
  end

  # GET
  def manage
    if logged_in?
      @user = current_user
      @players = Player.all
      @teams = Team.all
      @games = Game.all
    else
      render ''
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone_number, :email, :password)
  end

end
