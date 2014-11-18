# sudoku = [[ 6, 2,"","","","","", 1, 5],
#           [ 5,"","","","","","","", 3],
#           ["","","", 8,"", 9,"","",""],
#           ["","", 1, 6,"", 5, 2,"",""],
#           ["","","","","","","","",""],
#           ["","", 2, 3,"", 1, 7,"",""],
#           ["","","", 1,"", 4,"","",""],
#           [ 3,"","","","","","","", 6],
#           [ 7, 5,"","","","","", 3, 8]]


module Algorithm
  class Sudoku
    attr_accessor :matrix, :result, :missing_values, :missing_cols

    def initialize matrix
      @matrix = matrix
      @width = @matrix[0].length
      @height = @matrix.length
      @missing_values = Sudoku.missing_values @matrix
      @missing_cols = Sudoku.missing_cols @matrix
      # initialize result
      @result = Sudoku.clone @matrix
    end

    def resolve
      backtrack 0
    end

    def cells_in row
      @missing_values[row].permutation.to_a
    end

    def backtrack row
      return true if row >= @height
      if @missing_values[row].length > 0
        row_cells = cells_in row
      else
        return backtrack(row + 1)
      end
      
      row_cells.each do |sample|
        check = do_try row, sample
        if check
          if row == @length
            return true
          else
            check = backtrack(row + 1)
            
            if check
              return true
            else
              rollback row
            end
          end
        end
      end
      false
    end

    def do_try row, sample
      @missing_cols[row].each_with_index do |col, index|
        check = check_block?(row, col, sample[index]) && check_col?(col, sample[index])
        return false unless check
      end
      update row, sample
      true
    end

    def check_block? row, col, value
      block_row, block_col = block_of row, col
      block_row.each do |r|
        block_col.each do |c|
          return false if @result[r][c] == value
        end
      end
      true
    end

    def block_of row, col
      [detect_block(row), detect_block(col)]
    end

    def detect_block index
      case index
      when 0..2
        0..2
      when 3..5
        3..5
      when 6..8
        6..8
      end
    end

    def check_col? col, value
      (0..8).each do |r|
        return false if @result[r][col] == value
      end
      true
    end

    def update row, sample
      @missing_cols[row].each_with_index do |col, index|
        @result[row][col] = sample[index]
      end
    end

    def rollback row
      @missing_cols[row].each_with_index do |col, index|
        @result[row][col] = ""
      end      
    end

    class << self
      def clone matrix
        matrix.map { |row| row.map { |cell| cell } }
      end

      def missing_cols matrix
        matrix.map do |row|
          cols = []
          row.each_with_index { |cell, index| cols << index if cell.blank? }
          cols.compact
        end
      end

      def missing_values matrix
        sample = (1..9).to_a
        matrix.map { |row| sample - row.select { |cell| !cell.blank? } }
      end

      def dup? array
        array.uniq.length != array.length
      end

      def backtrack sudoku
        s = new(sudoku)
        s.resolve
        s.result
      end
    end
  end
end
