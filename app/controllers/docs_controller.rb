class DocsController < BaseController
  before_filter :search, only: [:index]

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def search
    if params[:q]
      analysis_keyword
      
      if @is_filename_search
        @results = RubyUtils::Doc.search_file(@keyword)
      else
        @results = RubyUtils::Doc.search(@keyword)
      end

      @results = Kaminari.paginate_array(@results).page(params[:page]).per(Settings.search.per_page)
    end
  end

  def analysis_keyword
    @keyword = model_params[:keyword]
    @is_filename_search = false
    if @keyword.present? && @keyword[0] == '@'
      @is_filename_search = true 
      @keyword = @keyword.slice(1..(@keyword.length - 1))
    end
  end

  def model_params
    params.require(:q).permit([:keyword, :filename])
  end
end
