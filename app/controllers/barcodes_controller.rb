require 'barby/barcode/code_128'
require 'barby/barcode/code_25'
require 'barby/barcode/code_25_interleaved'
require 'barby/barcode/code_25_iata'
require 'barby/barcode/code_39'
require 'barby/barcode/code_93'
require 'barby/barcode/gs1_128'
require 'barby/barcode/ean_13'
require 'barby/barcode/bookland'
require 'barby/barcode/ean_8'
require 'barby/barcode/upc_supplemental'
require 'barby/outputter/ascii_outputter'

class BarcodesController < BaseController
  helper_method :barcode_types

  def index
  end

  def create
    begin
      @barcodes = model.new(model_params[:content])
    rescue ArgumentError
      @error = true
    rescue
    end
    @barcode_strs = @barcodes.to_ascii.split("\n").map{|line| line.split("").
      map{|cell| cell == "#" ? true : false }} if @barcodes

    respond_to do |format|
      format.html { render "new" }
      format.js
    end
  end

  private
  def model
    @type = model_params[:type]
    if @type
      @type.constantize
    end
  end

  def model_params
    params.require(:barcode).permit([:content, :type])
  end

  def barcode_types
    [
     Barby::Code128A,
     Barby::Code128B,
     Barby::Code128C,
     Barby::Code25,
     Barby::Code25IATA,
     Barby::Code25Interleaved,
     Barby::Code39,
     Barby::Code93,
     Barby::EAN13,
     Barby::EAN8,
     Barby::GS1128,
     Barby::Bookland,
     Barby::UPCSupplemental
    ]
  end
end
