class UsersController < ApplicationController

  skip_before_filter :require_login, :only => [:new, :create]
  
  def admin
  end

  def profile
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:current_user_id] = @user.id
      flash[:success] = "You have signed up successfully!"
      redirect_to admin_path(@user.url)
    else
      flash[:error] = @user.errors.full_messages.first
      redirect_to :back
    end
  end
end
