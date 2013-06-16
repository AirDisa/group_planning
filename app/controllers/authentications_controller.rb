class AuthenticationsController < ApplicationController

  skip_before_filter :require_login

  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      session[:current_user_id] = authentication.user_id
      flash[:success] = "You successfully logged in!"
      redirect_to admin_path(current_user.url)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "You successfully authenticated this service!"
      redirect_to admin_path(current_user.url)
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save!
        session[:current_user_id] = user.id
        flash[:success] = "You have signed up successfully!"
        UserMailer.welcome_email(user).deliver
        redirect_to admin_path(user.url)
      else
        flash[:error] = user.errors.full_messages.last
        redirect_to :back
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "You successfully removed this service"
    redirect_to admin_path(current_user.url)
  end
end