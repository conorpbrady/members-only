class ApplicationController < ActionController::Base

  helper_method :current_user
  def logged_in_user


  end

  def sample_method
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user
    if(user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif user_id == cookies.signed[:user_id]
      @current_user = User.find_by(id: user_id)
    else
      nil
    end
    @current_user
  end


end
