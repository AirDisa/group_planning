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

    # have you checked the logs to see how many queries you are executing
    # as a result of the next few lines of code? i imagine theres a more efficient
    # way to do this...
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
      # try reidrect_to session.delete(:return_to) || admin_path(@user.url)
      url = session[:return_to] || admin_path(@user.url)
      session[:return_to] = nil
      redirect_to(url)
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
    # might be worth taking a gander at http://stackoverflow.com/questions/2778522/rails-update-attribute-vs-update-attributes
    current_user.update_attributes(:stripe_token => params[:code])
    event = Event.find(session[:event_id])
    set_creator_api(params[:code], event)
    redirect_to event_path(event.url)
  end
end
