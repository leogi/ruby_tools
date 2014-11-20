class RegexsController < BaseController

  def index
  end

  def create

    respond_to do |format|
      format.html { render "new" }
    end    
  end

  private
  def model_params
    params.require(:image).permit([:file, :base64])
  end
end
