class Feasibility2
  def mtx( h=80, base )
    if h == -1
      puts "END"
      return base
    end

    puts "h=#{h}"

    row = h / 9
    col = h % 9
    if base[row][col] != 0
      if ret = mtx( h - 1, base.dup )
        puts "RET2 #{ret}"
        return base
      end
    else
      pp base
      (1..9).each do |candidate|
        if check_dup?( row, col, base, candidate )
          puts "DUP, h=#{h} (#{row}:#{col}) can=#{candidate}"
          next
        else
          puts "Bingo, h=#{h} (#{row}:#{col}) can=#{candidate}"
          tmp_base = base.dup
          tmp_base[row][col] = candidate
          if ret = mtx( h - 1, tmp_base )
            puts "RET #{ret}"
            return ret
          end
        end
      end
      puts "LOOPEND"
      base[row][col] = 0
      pp base
    end
    nil
  end

  def check_dup?(row, col, base, candidate)
    return base[row].include?(candidate) \
    | base.transpose[col].include?(candidate) \
    | numbers_square( row, col, base ).include?(candidate)
  end

  def numbers_square(row, col, base)
    tl_row = row / 3 * 3
    tl_col = col / 3 * 3
    (tl_row..tl_row+2).map do |r|
      (tl_col..tl_col+2).map do |c|
        base[r][c]
      end
    end.flatten
  end

end
