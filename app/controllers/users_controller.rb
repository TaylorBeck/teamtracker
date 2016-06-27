class UsersController < ActionController::Base

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
  def login
    render 'users/login'
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone_number, :email, :password)
  end

end
