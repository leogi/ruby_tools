class Admin::StoriesController < Admin::ResourcesController
  before_filter :load_resource, only: [:publish, :unpublish]

  def publish
    if @resource.publish!
      render "publish_success"
    else
      render "publish_failed"
    end
  end

  def unpublish
    if @resource.unpublish!
      render "unpublish_success"
    else
      render "unpublish_failed"
    end
  end
end
