class Numplay

  def initialize( fn = nil )
    if fn
      @org = readfile( fn )
    else
      @org = [
        [0,0,6,0,5,0,0,0,9],
        [0,8,0,0,6,0,0,1,0],
        [7,0,3,0,0,2,8,0,0],
        [0,0,0,6,0,0,2,0,0],
        [6,3,0,0,1,0,0,4,7],
        [0,0,2,0,0,3,0,0,0],
        [0,0,7,5,0,0,3,0,2],
        [0,1,0,0,2,0,0,5,0],
        [9,0,0,0,3,0,4,0,0]
      ]
    end
    @result_permutation = []
  end
  attr_accessor :org

  def readfile( fn )
    open( fn ) do |fp|
      fp.each_line.map do |ln|
        ln.split(",").map { |n| n.to_i }
      end
    end
  end

  def main
    all_rows_permutations( 0, @org.dup )
  end

  def all_rows_permutations( row, base )
    return base if row == 9
    all_permutations[row].each do |row_numbers|
      base[row] = row_numbers
#      puts "#{row} #{row_numbers}"
#      puts "#{base}"
      next if dup_numbers?(base, row)
      all_rows_permutations( row + 1, base.dup )
    end
    base
  end

  def dup_numbers?( base, row_idx )
    base[row_idx].each_with_index do |number, col_i|
      (0..8).each do |row_i|
        next if row_i == row_idx
        tmp_a = numbers_col( col_i, base )
        tmp_a[row_idx] = 0
        if tmp_a.include?(number)
#          puts "!!!!!col!! #{number} in #{tmp_a}"
          return true 
        end
      end
      tmp_a = numbers_square( row_idx, col_i, base )
      tmp_a[row_idx%3*3+col_i%3] = 0
      if tmp_a.include?(number)
#        puts "!!!!!Sq!! #{number} in #{tmp_a}"
        return true 
      end
    end
    false
  end

  def all_permutations()
    (0..8).map do |row|
      set_permutation( row, 0, [] )
    end
  end

  def my_permutations( row )
    col = 0
    set_permutation( row, col, [] )
  end

  def set_permutation( row, col, prev_ans )
    if col == 0
      @result_permutation = []
    elsif col == 9
      @result_permutation << prev_ans
      return
    end

    availables(row)[col].each do |n|
      next if prev_ans.include?(n)
      set_permutation( row, col+1, prev_ans.dup << n )
    end
    @result_permutation
  end

  def numbers_col(col, org)
    org.each.map do |row|
      row[col] 
    end
  end

  def numbers_square(row, col, org)
    tl_row = row / 3 * 3
    tl_col = col / 3 * 3
    (tl_row..tl_row+2).map do |r|
      (tl_col..tl_col+2).map do |c|
        org[r][c]
      end
    end.flatten
  end

  def availables(row)
    @org[row].map.with_index do |number, col|
      if number != 0
        [number]
      else
        numbers = Array.new(9) {|i| i+1 }
        @org[row].each { |n| numbers.delete(n) if n != 0 }
        numbers_col(col, @org).each { |n| numbers.delete(n) if n != 0 }
        numbers_square(row, col, @org).each { |n| numbers.delete(n) if n != 0 }
        numbers
      end
    end
  end
end
