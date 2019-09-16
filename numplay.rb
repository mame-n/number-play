require "pp"

class Array
  def includes?( content )
    self.each.any? do |row|
      row.include?( content )
    end
  end
end

  
class Numplay

  def initialize( org_array )
    if org_array
      @org = org_array
    else
      @org = [
        [nil,nil,  6,nil,  5,nil,nil,nil,  9],
        [nil,  8,nil,nil,  6,nil,nil,  1,nil],
        [  7,nil,  3,nil,nil,  2,  8,nil,nil],
        [nil,nil,nil,  6,nil,nil,  2,nil,nil],
        [  6,  3,nil,nil,  1,nil,nil,  4,  7],
        [nil,nil,  2,nil,nil,  3,nil,nil,nil],
        [nil,nil,  7,  5,nil,nil,  3,nil,  2],
        [nil,  1,nil,nil,  2,nil,nil,  5,nil],
        [  9,nil,nil,nil,  3,nil,  4,nil,nil]
      ]
    end
  end
  
  def main
    while @org.includes?( nil )
      sweep_array
    end
    @org
  end
  
  def sweep_array
    (0..8).each do |y|
      (0..8).each do |x|
        next if @org[y][x]
        pos = find_all_possibility( x, y )
        @org[y][x] = pos[0] if pos.size == 1
      end
    end
  end

  def find_all_possibility( x, y )
    (1..9).each.select do |num|
      !@org[y].include?(num) &&
      !mk3x3array( x, y ).include?(num) &&
      !mk_x_array( x ).include?(num)
    end
  end
  
  def mk3x3array(x,y)
    (y/3*3..(y/3+1)*3-1).each.map do |y|
      (x/3*3..(x/3+1)*3-1).each.map do |x|
        @org[y][x]
      end
    end.flatten
  end

  def mk_x_array( x )
    (0..8).each.map do |y|
      @org[y][x]
    end
  end
end

if __FILE__ == $0
  pp Numplay.new( nil ).main
end
