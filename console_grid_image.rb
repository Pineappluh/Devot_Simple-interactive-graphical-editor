require './grid_image'

class ConsoleGridImage

  def initialize
    @grid_image = GridImage.new(0, 0)
    @running = false
  end

  def parse_input(input)
    input_data = input.chomp.split("")
    command = input_data[0]
    arguments = input_data[1..]
    [command, arguments]
  end

  def evaluate_input(command, arguments)
    case command
    when "I"
      x, y = arguments[0].to_i, arguments[1].to_i
      @grid_image = GridImage.new(y, x)
    when "C"
      @grid_image.clear
    when "L"
      x, y, c = arguments[0].to_i, arguments[1].to_i, arguments[2]
      @grid_image.color(y - 1, x - 1, c)
    when "V"
      x, y1, y2, c = arguments[0].to_i, arguments[1].to_i, arguments[2].to_i, arguments[3]
      @grid_image.fill_column(x - 1, y1 - 1, y2 - 1, c)
    when "H"
      x1, x2, y, c = arguments[0].to_i, arguments[1].to_i, arguments[2].to_i, arguments[3]
      @grid_image.fill_row(y - 1, x1 - 1, x2 - 1, c)
    when "F"
      x, y, c = arguments[0].to_i, arguments[1].to_i, arguments[2]
      @grid_image.fill_region(y - 1, x - 1, c)
    when "S"
      puts @grid_image.to_s
    when "X"
      @running = false
    else
      puts "Unknown command"
    end
  end

  def run
    @running = true

    while @running
      command, arguments = self.parse_input(gets)
      self.evaluate_input(command, arguments)
    end
  end

end