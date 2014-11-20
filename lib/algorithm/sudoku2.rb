module Algorithm
	class Sudoku2 < Backtrack
		attr_accessor :matrix, :result
		def initialize matrix
			super(matrix.length)

			@matrix = matrix
			@missing_values = Sudoku.missing_values @matrix
      @missing_cols = Sudoku.missing_cols @matrix
			@result = Sudoku.clone @matrix
		end

		def samples_in row
			@missing_values[row].permutation.to_a
		end

		def missing_value? row
			@missing_values[row].length > 0
		end

		def try_sample row, sample
      @missing_cols[row].each_with_index do |col, index|
        check = valid_block?(row, col, sample[index]) && valid_col?(col, sample[index])
        return false unless check
      end
      update row, sample
      true
		end

		def rollback row
			@missing_cols[row].each_with_index do |col, index|
        @result[row][col] = 0
      end      
		end

		def valid_block? row, col, value
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

    def valid_col? col, value
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

    class << self
      def backtrack sudoku
        s = new(sudoku)
        s.run
        s.result
      end
    end
	end
end