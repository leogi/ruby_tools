require 'socket'

puts "Open connection"

def initialize_socket
  hostname = "ngrok.com"
  port = "59236"

  @connection = TCPSocket.open(hostname, port)
  @connection.sync = true

  @cols_sum = []
  @rows_sum = []
  11.times do |i|
    line = @connection.gets
    if i == 2
      @cols_sum = line.chop.split(" ").map{|i| i.to_i}
    end
    if i == 5 || i == 7 || i == 9
      @rows_sum << line.chop.split(" ").first.to_i
    end
    puts line.chop
  end
  @length = @cols_sum.length - 1
  @dictionary = []
  @current_length = 3
  find_rows 0
end


def combine array, n
  array.combination(n).map{|i| i}
end

def check_available_cols row
  available_cols = (0..@length).select{|i| @cols_sum[i] > 0}
  if @rows_sum[(row + 1)..@length].max > available_cols.length
    false
  else
    true
  end
end

def find_cols row
  available_cols = (0..@length).select{|i| @cols_sum[i] > 0}
  row_sum = @rows_sum[row]
  combine(available_cols, row_sum)
end

def find_rows row
    return true if row > @length
    r_cols = []
    if(@rows_sum[row] > 0)
      r_cols = find_cols(row)
      #puts "#{row}#{r_cols.count}" if row > 6
    else
      check = find_rows(row + 1)
      if check
        return true
      else
        return false
      end
    end

    r_cols.each do |cs|
      cs.each do |col|
        @dictionary << [row, col]
        @cols_sum[col] -= 1
      end 

      if row == @length
        return true
      else
        if check_available_cols(row)
          check = find_rows(row + 1)
          if check == true
            return true
          else
            cs.length.times {|_| @dictionary.pop}
            cs.each do |col|
              @cols_sum[col] += 1
            end 
          end
        else
          cs.length.times {|_| @dictionary.pop}
          cs.each do |col|
            @cols_sum[col] += 1
          end 
        end
      end
   end
   false
end


=begin
@cols_sum = [7,5,6,5,6,5,4,7,3]#[2,5,4,3,3,5,2,3]
@rows_sum = [5,6,4,5,7,3,8,4,6]#[4,3,4,2,4,3,3,4]
@current_length = 3
@length = @cols_sum.length - 1
@dictionary = []
find_rows 0
=end

initialize_socket
puts @current_length

while true do
  closed = false
  @dictionary.each do |d|
    row, col = d
    @connection.puts "#{row} #{col}"
    

    _loop = 11 + (@current_length - 3) * 2
    _loop.times do |i|
      line = @connection.gets
      if line
        #puts line.chop
      else 
        closed = true
      end
    end

  end
  if closed
      puts "Try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      initialize_socket
  else
    @current_length += 1
    @cols_sum = []
    @rows_sum = []
    (11 + (@current_length - 3) * 2).times do |i|
      line = @connection.gets
      if i == 2
        @cols_sum = line.chop.split(" ").map{|i| i.to_i}
      end
      if i >= 5 && i % 2 == 1
        @rows_sum << line.chop.split(" ").first.to_i
      end
      puts line.chop
    end
    @length = @cols_sum.length - 1
    @dictionary = []
    puts @current_length
    find_rows 0
  end
end
