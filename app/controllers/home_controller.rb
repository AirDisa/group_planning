class HomeController < ApplicationController

  skip_before_filter :require_login

  def index
    @user = current_user || User.new
  end
end