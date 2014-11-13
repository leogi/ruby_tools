class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include BaseRedirect

  protect_from_forgery with: :exception
  respond_to :html, :json
  helper_method :current_locale
  helper_method :is_admin?

  def set_locale
    I18n.locale = params[:locale] ? params[:locale].to_sym : I18n.default_locale
    session[:locale] = I18n.locale
    current_user.update_attributes(language: I18n.locale.to_s) if current_user
    redirect_to root_path
  end

  rescue_from CanCan::AccessDenied do |exception|  
    flash[:error] = "Access denied!"  
    redirect_to root_url  
  end
  
  private
  def current_locale
    {en: "English", ja: "Japanese", vn: "Vietnamese"}[I18n.locale]
  end

  def is_admin?
    self.is_a? Admin::BaseController
  end

  def root
    is_admin? ? admin_root_path : root_path
  end
end
