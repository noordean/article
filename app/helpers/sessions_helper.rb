module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

  def is_admin?
    !current_user.nil? && current_user.role == "admin"
  end
end
