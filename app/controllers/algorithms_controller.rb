class AlgorithmsController < BaseController
  helper_method :algorithms

  def index
  end

  def new
  end

  def create
    @decrypt = model_params[:decrypt] == "1" ? true : false
    @content = model_params[:content]
    @type = model_params[:type].to_sym
    exec_crypt
    @results = @results.force_encoding("utf-8").
      encode('UTF-8', :invalid => :replace, :replace => '?') if @results.is_a? String

    respond_to do |format|
      format.js
    end    
  end

  private
  def caesar_bruteforce
    @results = model.caesar_bruteforce @content, @decrypt    
  end

  def ascii_to_binary
    @results = model.ascii_to_binary(@content)
  end

  def ascii_to_hex
    @results = model.ascii_to_hex(@content)
  end

  def hex_to_ascii
    @results = model.hex_to_ascii(@content)
  end

  def base64
    @results = model.base64(@content, @decrypt)
  end

  def uuencode_uudecode
    @results = model.uuencode(@content, @decrypt)    
  end

  def md5
    @results = model.md5(@content)
  end

  # Encrypt/Decrypt
  def exec_crypt
    @results = model.send(@type, @content, @decrypt)
  end

  def model_params
    params.require(:algorithm).permit([:content, :decrypt, :type])
  end

  def model
    algorithms[model_params[:type].to_sym].constantize
  end

  def algorithms
    {
      caesar_bruteforce: "Algorithm::Rot",
      ascii_to_binary: "Algorithm::Convert",
      ascii_to_hex: "Algorithm::Convert",
      hex_to_ascii: "Algorithm::Convert",
      base64: "Algorithm::Convert",
      uuencode_uudecode: "Algorithm::Convert",
      md5: "Algorithm::Convert",
      html_entities: "Algorithm::Convert"
    }
  end
end
