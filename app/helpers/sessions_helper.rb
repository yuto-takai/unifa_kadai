module SessionsHelper
  def log_in(user)
    session[:user_name] = user.id
  end

  def current_user
    if session[:user_name]
      @current_user ||= User.find_by(id: session[:user_name])
    end
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete(:user_name)
    @current_user = nil
  end

  def login_check
    redirect_to root_path unless logged_in?
  end
end
