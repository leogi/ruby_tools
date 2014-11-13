class ImagesController < BaseController
  def new
  end

  def create
    @base64 = Base64.encode64(model_params["file"].tempfile.read)
    respond_to do |format|
      format.html { render "new" }
    end    
  end

  def base64_to_image    
  end

  def create_base64_to_image
    @base64 = model_params["base64"]
    # Unneccesary
    #File.open('image.png', 'wb') do |f|
    #  f.write(Base64.decode64(@base64))
    #end
    respond_to do |format|
      format.html { render "base64_to_image" }
      format.js
    end    
  end

  private
  def model_params
    params.require(:image).permit([:file, :base64])
  end
end
