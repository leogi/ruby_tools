require 'rqrcode'

class QrCodesController < BaseController
  helper_method :separators
  before_filter :analysic_character_matrix, only: [:create]

  def new
  end

  def create
    respond_to do |format|
      format.html { render "new" }
      format.js
    end
  end

  def generate
    @qr_code = RQRCode::QRCode.new(model_params[:content], 
                                   size: (size = model_params[:size]).blank? ? 2 : size.to_i)
    respond_to do |format|
      format.js
    end
  end

  private
  def analysic_character_matrix
    @content = model_params["content"]
    @condition = model_params["condition"]
    @separator = separators[model_params["separator"]] || ""
    @character_matrix = @content.split("\r\n").map { |line| 
      cells = line.split(@separator)
      if @condition && !@condition.blank?
        cells.map do |cell|
          analysic_with_condition cell
        end
      else
        cells
      end
    }
  end

  def analysic_with_condition cell
    eval(@condition)
  end

  def model_params
    params.require(:qr_code).permit([:content, :condition, :separator, :size])
  end

  def separators
    {
      "Space" => " ",
      "Comma" => ",",
      "Semi-colon" => ";"
    }
  end
end
