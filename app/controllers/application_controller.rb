class ApplicationController < ActionController::Base
  check_authorization unless: :devise_controller?
  skip_authorization_check only: [:index]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery #with: :exception

  #before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_variants

  def index
  end

  rescue_from CanCan::AccessDenied do |ex|
    respond_to do |format|
      format.html { redirect_to root_url, alert: ex.message }
      format.json { render json: { errors: ex.message}, status: 401}
    end
  end

  protected

  # http://railscasts.com/episodes/352-securing-an-api
  # Require a session token to do anything with laps
  def ensure_session_auth(sess)
    if request.variant == :opentracker
      authenticate_or_request_with_http_token do |token, options|
        sess.key.key == token
      end
    else
      true
    end
  end

  private

  def set_variants
    case request.user_agent
      when /openTracker/i
        request.variant = :opentracker
    end
  end
end
