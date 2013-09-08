class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionHelper

  WillPaginate.per_page = 10

  def handle_unverified_request
    sign_out
    super
  end

  helper_method :current_user

  def authenticate_user
    if current_user.nil?
      flash[:error] = 'You must be signed in to view that page.'
      @msg = 'You must be signed in to view that page.'
      redirect_to :signin
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url, :alert => exception.message
  end


end