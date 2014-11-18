class SudokusController < BaseController
  before_filter :sudoku_matrix, only: [:create]
  def index
  end

  def create
    @resolve = Algorithm::Sudoku.backtrack @matrix

    respond_to do |format|
      format.html { render "new" }
      format.js
    end
  end

  private
  def sudoku_matrix
    @matrix = []
    model_params[:cell].each do |k, v|
      row = []
      v.each do |k, v|
        row << (v.blank? ? "" : v.to_i)
      end
      @matrix << row
    end
  end

  def model_params
    params.require(:sudoku).permit([:cell => (1..9).to_a.map{|i| i.to_s}])
  end
end
