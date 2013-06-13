class SessionsController < ApplicationController

  skip_before_filter :require_login

  def new
    @session = current_user || User.new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      flash[:success] = "You successfully logged in!"
      redirect_to admin_path(user.url)
    else
      flash[:error] = user.errors.messages
      redirect_to root_path
    end
  end

  def logout
    session.clear
    flash[:success] = "You successfully logged out!"
    redirect_to root_path
  end

end
