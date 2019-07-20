class SessionsController < ApplicationController



  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      log_in user
      redirect_to root_url
    else
      flash[:danger] = "invalid user/password"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end


  private
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
      if(user_id == session[:user_id])
        @current_user ||= User.find_by(id: user_id)
      elsif user_Id == cookies.signed[:user_id]
        @current_user = User.find_by(id: user_id)
      else
        # something
      end
    end



end
