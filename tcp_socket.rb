require 'socket'

puts "Open connection"

def initialize_socket
  hostname = "ngrok.com"
  port = "59236"

  @connection = TCPSocket.open(hostname, port)
  @connection.sync = true

  @cols = []
  @rows = []
  11.times do |i|
    line = @connection.gets
    if i == 2
      @cols = line.chop.split(" ").map{|i| i.to_i}
    end
    if i == 5 || i == 7 || i == 9
      @rows << line.chop.split(" ").first.to_i
    end
    puts line.chop
  end
  puts @cols.join("/")
  puts @rows.join("/")
  @length = @cols.length - 1
  @sum = @cols.sum
  @dictionary = []
  @count = 0
  try(1)
  puts @dictionary.map{|d| "(" + d.join(" ") + ")"}
end

# @cols = gets.chop.split(" ").map{|i| i.to_i}
# @rows = gets.chop.split(" ").map{|i| i.to_i}
@cols = [3,5,2,5,3,3]
@rows = [2,2,3,4,5,5]

@length = @cols.length - 1
@sum = @cols.sum
@dictionary = []
@count = 0


def check i, r, c
  puts i
  (r..@length).each do |row|
    (0..@length).each do |col|
      if !@dictionary.include?([row, col]) && @cols[col] > 0 && @rows[row] > 0
        @dictionary << [row, col]
        @cols[col] -= 1;
        @rows[row] -= 1;
        puts "#{row} #{col}"
        if i == @sum
          return true
        else
          check = check(i + 1, row, col)
          if check
            return true
          else
            @dictionary.pop
            @cols[col] += 1
            @rows[row] += 1
          end
        end
      end
    end
  end
  
  return false
end

check(1, 0, 0)

=begin
initialize_socket
@current_length = 3
while true do
  @dictionary.each do |d|
    row, col = d
    puts "#{row} #{col}"
    @connection.puts "#{row} #{col}"
    
    closed = false
    (11 + (@current_length - 3) * 2).times do |i|
      line = @connection.gets
      if line
        puts line.chop
      else 
        closed = true
      end
    end
    if closed
      puts "Try again!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      initialize_socket
    end
  end

  @current_length += 1
  @cols = []
  @rows = []
  (11 + (@current_length - 3) * 2).times do |i|
    line = @connection.gets
    if i == 2
      @cols = line.chop.split(" ").map{|i| i.to_i}
    end
    if i >= 5 && i % 2 == 1
      @rows << line.chop.split(" ").first.to_i
    end
    puts line.chop
  end
  puts @cols.join("/")
  puts @rows.join("/")
  @length = @cols.length - 1
  @sum = @cols.sum
  @dictionary = []
  @count = 0
  try(1)
  puts @dictionary.map{|d| "(" + d.join(" ") + ")"}
  
end
=end
