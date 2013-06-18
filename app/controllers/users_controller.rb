class UsersController < ApplicationController

  skip_before_filter :require_login, :only => [:new, :create, :validate_email]

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

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:error] = "You can only edit your own profile"
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    if @user.update_attributes(params[:user])
      flash[:success] = "You have updated your profile."
      redirect_to profile_path(@user.url)
    else
      flash[:error] = @user.errors.full_messages.last
      redirect_to :back
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:current_user_id] = @user.id
      flash[:success] = "You have signed up successfully!"
      UserMailer.welcome_email(@user).deliver
      redirect_to admin_path(@user.url)
    else
      flash[:error] = @user.errors.full_messages.last
      redirect_to :back
    end
  end

  def validate_email
    email = params[:user][:email].downcase
    render :text => (User.find_by_email(email) ? "invalid" : "valid")
  end

  def stripe
    current_user.update_attributes(:stripe_token => params[:code])
    redirect_to profile_path(current_user.url)
  end
end
