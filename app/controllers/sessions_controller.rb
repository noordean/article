class SessionsController < ApplicationController
  before_action :redirect_admin, only: [:new]

  def new
  end

  def login
    user = User.find_by(email: login_param[:email])
    if user && user.authenticate(login_param[:password])
      log_in user
      redirect_to user
    else
      flash[:danger] = "Incorrect email/password combination"
      redirect_to login_path
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to login_path
  end

  private

  def redirect_admin
    if is_admin?
      redirect_to user_path(current_user)
    end
  end

  def login_param
    params.require(:session).permit(:email, :password)
  end
end
