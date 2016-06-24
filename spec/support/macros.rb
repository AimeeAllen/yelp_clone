def sign_in_user(specified_user=nil)
  user = specified_user || Fabricate(:user)
  visit sign_in_path
  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def no_logged_in_user
  session[:user_id] = nil
end

def logged_in_user(specified_user=nil)
  user = specified_user || Fabricate(:user)
  session[:user_id] = user.id
end