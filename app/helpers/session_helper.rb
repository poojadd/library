module SessionHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user

    @current_user ||= User.find(cookies[:current_user_id])  if cookies[:current_user_id]

  end

  def authenticate_user (pass1, pass2)


    if pass1 == pass2
      p 'true'
      true
    else
      p 'false'
      false
    end
  end
end
