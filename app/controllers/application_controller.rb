class ApplicationController < ActionController::Base
  check_authorization unless: :devise_controller?
  skip_authorization_check only: [:index]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery #with: :exception
  #before_filter :configure_permitted_parameters, if: :devise_controller?

  def index
  end

  rescue_from CanCan::AccessDenied do |ex|
    redirect_to root_url, alert: ex.message
  end
end
