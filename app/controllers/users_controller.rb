class UsersController < ApplicationController

  skip_before_filter :require_login, :only => [:new, :create]

  def admin
    @user = User.find_by_url(params[:slug])
    @event = Event.new
    if @user != current_user
      redirect_to root_path
    end
  end

  def profile
    @user = User.find_by_url(params[:slug])
    @created_pending = Invitee.pending(@user.created_events)
    @created_going = Invitee.going(@user.created_events)
    @created_not_going = Invitee.not_going(@user.created_events)
    @invited_pending = Invitee.pending(@user.events)
    @invited_going = Invitee.going(@user.events)
    @invited_not_going = Invitee.not_going(@user.events)
  end

  def update

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
