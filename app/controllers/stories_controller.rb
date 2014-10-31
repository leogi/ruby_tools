class StoriesController < BaseController
  def index
    @stories = Story.where(language: current_locale).order("created_at DESC")
    @current_story = params[:story] ? Story.find_by_id(params[:story]) : @stories.first
    @next_story = @current_story.next(@stories)
    @prev_story = @current_story.previous(@stories)
    @translate_languages = @current_story.origin.available_languages - [@current_story.language]
    respond_to do |format|
      format.html
    end
  end

  def translate
    @story = Story.find_by_id(params[:id])
    @translation = @story.origin.locale_stories.where(language: params[:language]).first
    respond_to do |format|
      format.js
    end
  end

  private
  def current_locale
    {en: "English", ja: "Japanese", vn: "Vietnamese"}[I18n.locale]
  end
end
