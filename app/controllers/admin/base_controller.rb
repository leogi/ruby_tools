class Admin::BaseController < ApplicationController
  authorize_resource
  respond_to :html, :js, :json, :csv

  before_filter :check_admin_role

  private
  def check_admin_role
    unless current_user && current_user.admin?
      redirect_to root_path, notice: "Access denied"
    end
  end
  # def authenticate
  #  authenticate_or_request_with_http_basic('Administration') do |username, password|
  #    md5_of_password = Digest::MD5.hexdigest(password)
  #    username == 'admin' && md5_of_password == '8730c3ebf1c8a92b91381bc1ac58fcc3'
  #  end
  # end
end
