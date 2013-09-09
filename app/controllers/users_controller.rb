class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save

      flash.now.alert = "Welcome to the Sample App!"

      if params[:remember_me]
        cookies.permanent[:auth_token] = @user.auth_token
      else
        cookies[:auth_token] = @user.auth_token
      end
      cookies[:current_user_id] = @user.id


      redirect_to users_path
    else

      respond_to do |format|
        format.html { render "new" }
        format.js
      end

    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(users_path, :notice => 'User was successfully updated.') }

      else
        format.html { render :action => "edit" }
      end
    end
  end

  def index
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy

    @user = User.find(params[:id])
    @user.destroy
    p 'user deleted'


  end

end
