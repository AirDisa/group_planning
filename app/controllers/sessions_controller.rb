class SessionsController < ApplicationController

  skip_before_filter :require_login

  def new
    @session = current_user || User.new
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      flash[:success] = "You successfully logged in!"
      url = session[:return_to] || admin_path(user.url)
      session[:return_to] = nil
      redirect_to(url)
    else
      flash[:error] = "Unsuccessful login. Please try again."
      redirect_to root_path
    end
  end

  def logout
    session.clear
    flash[:success] = "You successfully logged out!"
    redirect_to root_path
  end

end
