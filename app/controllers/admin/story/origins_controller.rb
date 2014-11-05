class Admin::Story::OriginsController < Admin::ResourcesController
  skip_authorize_resource
  skip_authorization_check
  load_and_authorize_resource :class => ::Story::Origin.name, except: [:create]
  check_authorization
  before_filter :initialize_event, only: [:create, :update]
  # Override TODO refactoring
  def model_name
    ::Story::Origin.name
  end 

  def export
    @origins = Story::Origin.all
    respond_with(@origins.map { |s| s.story_json })
  end

  def import

  end

  def initialize_event
    if ["published", "preview"].include? params[:commit]
      @resource.state = params[:commit]
    end
  end
end
