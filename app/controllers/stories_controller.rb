class StoriesController < BaseController
  def index
    @stories = Story::Origin.all
    @current_story = params[:story] ? Story.find_by_id(params[:story]) : @stories.first
    @translate_languages = @current_story.origin.available_languages - [@current_story.language]
    respond_to do |format|
      format.html
    end
  end

  def translate
    @story = Story.find_by_id(params[:id])
    @translation = @story.origin.translations.where(language: params[:language]).first
    respond_to do |format|
      format.js
    end
  end
end
