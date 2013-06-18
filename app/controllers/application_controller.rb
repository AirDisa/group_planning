class ApplicationController < ActionController::Base

  include ApplicationHelper
  include StripeHelper

  protect_from_forgery

  before_filter :require_login

  private

  def require_login
    unless logged_in?
      session[:return_to] = request.fullpath
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
    end
  end

  def logged_in?
    !!current_user
  end
end
