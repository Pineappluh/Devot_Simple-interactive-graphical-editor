require 'set'

class GridImage

  def initialize(rows, columns)
    @rows = rows
    @columns = columns
    @grid = Array.new(rows){Array.new(columns, 'O')}
  end

  def clear
    @grid = Array.new(@rows){Array.new(@columns, 'O')}
  end

  def color(row, column, color)
    if (row).between?(0, @rows - 1) and (column).between?(0, @columns - 1)
      @grid[row][column] = color
    end
  end

  def fill_column(column, start_row, end_row, color)
    (start_row...end_row + 1).each do |row|
      self.color(row, column, color)
    end
  end

  def fill_row(row, start_column, end_column, color)
    (start_column...end_column + 1).each do |column|
      self.color(row, column, color)
    end
  end

  def fill_region(row, column, color, visited=Set.new)
    visited.add([row, column])

    directions = [[1, 0], [0, 1], [-1, 0], [0, -1]]
    directions.each do |dx, dy|
      if (row + dx).between?(0, @rows - 1) and (column + dy).between?(0, @columns - 1)
        neighbor = [row + dx, column + dy]
        if @grid[neighbor[0]][neighbor[1]] == @grid[row][column] and not visited.include?(neighbor)
          self.fill_region(neighbor[0], neighbor[1], color, visited)
        end
      end
    end

    self.color(row, column, color)
  end

  def to_s
    grid = ""
    @grid.each do |row|
      current_row = ""
      row.each do |color|
        current_row << color
      end
      current_row << "\n"
      grid << current_row
    end
    grid
  end

end