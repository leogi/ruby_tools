class CommentsController < ResourcesController
  prepend_before_filter :load_story, only: [:edit, :create, :edit, :destroy, :update]

  def edit
    respond_to do |format|
      format.js
    end
  end

  def create
    @resource.assign_attributes(model_params)
    @resource.user = current_user
    @resource.story = @story
    respond_to do |format|
      if @resource.save
        format.js { render "create_success" }
      else
        format.js { render "create_failed" }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource.update_attributes(model_params)
        format.js { render "update_success" }
      else
        format.js { render "update_failed" }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @resource.destroy
        format.js { render "destroy_success" }
      else
        format.js { render "destroy_failed" }
      end
    end
  end

  private
  def load_story
    @story = Story.find_by_id(params[:story_id])
  end
end
