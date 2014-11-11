module BaseRedirect
  extend ActiveSupport::Concern

  included do
    before_filter :store_request
  end

  def store_request
    if store_request_condition?
      session[:prev_request_url] = request.fullpath
      puts session[:prev_request_url]
    end
  end

  def redirect_back default = nil
    redirect_to(session[:prev_request_url] || default || root_path)
    session.delete(:prev_request_url)
  end
  
  private
  def store_request_condition?
    request.filtered_parameters["format"] != "js" && request.method == "GET"
  end
end
