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



end
