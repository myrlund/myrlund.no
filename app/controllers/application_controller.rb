class ApplicationController < ActionController::Base
  protect_from_forgery

  check_authorization :unless => :devise_controller?

  rescue_from CanCan::AccessDenied, with: :access_denied

  # before_filter :set_locale
  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
    else
      I18n.locale = extract_locale_from_accept_language_header if extract_locale_from_accept_language_header
    end
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  before_filter :store_location
  def store_location
    unless params[:controller] == "devise/sessions"
      url = request.path
      session[:after_sign_in_path] = url
    end
  end

  before_filter :redirect_to_locale_path
  def redirect_to_locale_path
    unless params[:locale]
      redirect_to "/#{I18n.locale}" + request.path
    end
  end

private

  def extract_locale_from_accept_language_header
    accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
    accept_language && accept_language.scan(/^[a-z]{2}/).first
  end

  def default_url_options(options={})
    {
      locale: I18n.locale,
    }
  end

  def access_denied(exception)
    if user_signed_in?
      redirect_to root_url, :alert => exception.message
    else
      redirect_to new_user_session_path
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    session[:after_sign_in_path] || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer || root_path
  end

end
