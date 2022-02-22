class Robot
  attr_accessor :x, :y, :f

  def initialize(x, y, f)
    @x = x
    @y = y
    @f = f
  end


  def check?(x, y)
    (0..6).include?(x) && (0..5).include?(y)
  end

  def place(set_to_x, set_to_y, look_to_f)
    # сделать проверку на границы стола
    return unless check?(set_to_x, set_to_y)
    @x = set_to_x
    @y = set_to_y
    @f = look_to_f
  end

  def move
    return unless check?(@x, @y)

    location_x = @x
    location_y = @y
    case @f
    when :north
      location_y = @y + 1
    when :east
      location_x = @x + 1
    when :south
      location_y = @y - 1
    when :west
      location_x = @x - 1
    end

    return unless check?(location_x, location_y)
    @x = location_x
    @y = location_y

  end


  def rotate_to_right
    # сделать проверку на границы стола
    return unless check?(@x, @y)
    case @f
    when :north
      @f = :east
    when :east
      @f = :south
    when :south
      @f = :west
    when :west
      @f = :north
    end
  end

  def rotate_to_left
    3.times {rotate_to_right}
  end

  def report

    return unless check?(@x, @y)
    print @x, "," , @y, ",", @f.upcase
    puts
  end

  def robot_try
    loop do

      print "Введите команду: "
      command = gets.upcase.chomp

      case command
      when "MOVE"
        move
      when "LEFT"
        rotate_to_left
      when "RIGHT"
        rotate_to_right
      when "REPORT"
        report
      else
        # 1. РАЗБИТЬ НА ДВЕ ЧАСТИ "ПО ПРОБЕЛУ"
        params = command.split

        # 2. ВТОРУЮ ЧАСТЬ РАЗБИТЬ НА АРГУМЕНТЫ "ПО ЗАПЯТОЙ"
        arg = params[1].split(',')

        # 3. ПЕРЕДАТЬ ПОЛУЧЕННЫЕ АРГУМЕНТЫ В МЕТОД place(x, y, f)
        place(arg[0].to_i, arg[1].to_i, arg[2].downcase.to_sym)
      end
      # report
    end
  end
end


r_t = Robot.new(-1, -1, :north)
r_t.robot_try


