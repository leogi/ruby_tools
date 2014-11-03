class ResourcesController < BaseController
  helper_method :model_name, :model
  before_filter :load_resources, only: [:index]
  before_filter :load_resource, only: [:edit, :update, :destroy]
  before_filter :initialize_resource, only: [:new, :create]

  def model_name
    controller_name.classify
  end

  def model
    model_name.constantize
  end	
  
  def instance_name
    controller_name.singularize
  end

  private
  def load_resources
    @search = model.search(params[:q])
    @collection = @search.result.page(params[:page]).per(paginate_per_page)
    instance_variable_set("@#{controller_name}", @collection)
  end

  def load_resource
    @resource = model.find(params[:id])
    instance_variable_set("@#{instance_name}", @resource)
  end

  def initialize_resource
    @resource = model.new
    instance_variable_set("@#{instance_name}", @resource)
  end

  def paginate_per_page
    Settings.resources.per_page
  end
  
  def model_params
    params.require(instance_name.to_sym).permit(model.permit_attributes)
  end
end
