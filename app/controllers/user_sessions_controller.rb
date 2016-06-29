class UserSessionsController < ApplicationController

  # GET
  def new
  end

  def create
    if login(params[:user_sessions][:email], params[:user_sessions][:password])
      redirect_back_or_to(games_path)
    else
      render action: :new
    end
  end

  def destroy
    logout
    redirect_to :root
  end

end
