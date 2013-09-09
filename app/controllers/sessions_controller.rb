class SessionsController < ApplicationController

  def new
        @session = Session.new
	end


  def create
    @session = Session.new(params[:session])

    if @session.save
      user = User.authenticate(params[:session][:email], params[:session][:password])


      if user
        if params[:remember_me]
          cookies.permanent[:auth_token] = user.auth_token
        else
          cookies[:auth_token] = user.auth_token
        end
        cookies.permanent[:current_user_id] = user.id
        redirect_to root_url, :notice => "Logged in!"
      else
        flash.now.alert = "Invalid email or password"
        render "new"
      end
    end
  end

  def destroy

    cookies.delete :current_user_id
    cookies.delete :auth_token
    cookies.delete :remember_token
    @current_user = nil

    #session[:current_user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

=begin
  def create
     p "." * 100
     @session = Session.new(params[:session])
    @email =  params[:session][:email]
    @user = User.where(:email => @email)
      @msg = ""
     p @user.first.password_digest

     if @session.save
       if authenticate_user(@user.first.password_digest, @session.password )
         sign_in user
         session[:current_user_id] = user.id
       else
         @msg = "Invalid Email/password."
         Session.find(@session.id).destroy
         respond_to do |format|
           format.html { render "new" }
           format.js
         end
       end
     else
       respond_to do |format|
         format.html { render "new" }
         format.js
       end
     end

  end
=end
=begin
  def destroy
 #   @current_user = sessions[:current_user_id] = nil
  #  flash[:notice] = "You have successfully logged out"
   # Session.find(params[:id]).destroy
    sign_out
    redirect_to root_url

    respond_to do |format|
      format.html { redirect_to mybooks_url }
      format.js   { render :nothing => true }
    end

  end
=end
end
