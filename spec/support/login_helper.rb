require 'capybara/rails'

module LoginHelpers

  def user_login(user)
    visit root_path
    click_link "log in"

    fill_in 'email',    with: user.email
    fill_in 'password', with: "Password1"
    click_button "Sign In"
  end

  def user_signup(user)
    visit root_path
    click_link "join"

    fill_in 'user_first_name', with: user.first_name
    fill_in 'user_last_name',  with: user.last_name
    fill_in 'user_email',      with: user.email
    fill_in 'user_password',   with: user.password
    fill_in 'user_password_confirmation', with: user.password_confirmation

    click_button "Create Account"
  end

end
