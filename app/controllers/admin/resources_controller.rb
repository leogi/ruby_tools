class Admin::ResourcesController < Admin::BaseController
  check_authorization
  helper_method :model_name, :model
  before_filter :load_resources, only: [:index]
  before_filter :load_resource, only: [:edit, :update, :destroy, :show]
  before_filter :initialize_resource, only: [:new, :create]
  before_filter :initialize_for_create, only: [:create]

  def new
    respond_with(@resource)
  end

  def show
  end

  def create
    @resource.assign_attributes(model_params)
    if @resource.save
      redirect_to redirect_after_create_path
    else
      render "new"
    end
  end

  def edit
    respond_with(@resource)
  end

  def update
    if @resource.update_attributes(model_params)
      redirect_to redirect_after_update_path
    else
      render "edit"
    end
  end

  def destroy
    @resource.destroy
    redirect_to redirect_after_delete_path
  end

  def model_name
    controller_name.classify
  end

  def model
    model_name.constantize
  end	
  
  def instance_name
    model_name.tableize.gsub("/", "_").singularize
  end

  def namespace_controller_name
    model_name.tableize.gsub("/", "_")
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

  def initialize_for_create
  end

  def paginate_per_page
    Settings.resources.per_page
  end

  def resource_index_path
    send "admin_#{namespace_controller_name}_path"
  end

  def resource_edit_path
    send "edit_admin_#{instance_name}_path"
  end

  def resource_new_path
    send "new_admin_#{instance_name}_path"
  end

  def redirect_after_create_path
    resource_index_path
  end

  def redirect_after_update_path
    resource_index_path
  end

  def redirect_after_delete_path
    resource_index_path
  end

  def model_params
    params.require(instance_name.to_sym).permit(model.permit_attributes)
  end
end
