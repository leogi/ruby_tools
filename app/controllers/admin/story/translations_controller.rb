class Admin::Story::TranslationsController < Admin::ResourcesController
  skip_authorize_resource
  skip_authorization_check
  load_and_authorize_resource :class => ::Story::Translation.name, except: [:create]
  check_authorization
  prepend_before_filter :load_story_origin

  # Override TODO refactoring
  def model_name
    ::Story::Translation.name
  end 

  private
  def initialize_for_create
    @resource.story = @origin
  end

  def load_story_origin
    @origin = Story::Origin.find_by_id(params[:origin_id])
  end

  def load_resources
    @search = @origin.translations.search(params[:q])
    @collection = @search.result.page(params[:page]).per(paginate_per_page)
    instance_variable_set("@#{controller_name}", @collection)
  end

  def load_resource
    @resource = @origin.translations.find_by_id(params[:id])
    instance_variable_set("@#{instance_name}", @resource)
  end

  def resource_index_path
    admin_story_origin_translations_path(@origin)
  end

  def resource_edit_path
    edit_admin_story_translation_path(@origin)
  end

  def resource_new_path
    new_admin_story_translation_path(@origin)
  end
end
