require 'colorize'



class MasterMind
  attr_accessor :code_breaker_playground, :code_maker_playground, :code_generated

  def initialize
    @code_breaker_playground =  [
      [" ", " ", " ", " "],
      [" ", " ", " ", " "],
      [" ", " ", " ", " "],
      [" ", " ", " ", " "],
      [" ", " ", " ", " "],
      [" ", " ", " ", " "],
    ]


    @code_generated = []
 
    @code_maker_playground = [
      [" ", " ", " ", " "],
      [" ", " ", " ", " "],
      [" ", " ", " ", " "],
      [" ", " ", " ", " "],
      [" ", " ", " ", " "],
      [" ", " ", " ", " "],
    ]


  end

  def print_hole(color)
    if color != " "
     print "•".colorize(:"#{color}")
    else
      print " ".colorize(:red)
    end

  end

  def start()

    self.infos

    a = true

    while a == true

      puts "\n1-Computer Guess"
      puts "2-Human Guess"

      print "Choose one of these modes: "

      choice = gets.chomp.to_i

      if (0..2).include?(choice)

         if choice == 1
          system("cls")
          self.generate_code()
          self.print_board()
          self.play()
        elsif choice == 2
          system("cls")
          self.color_input(3)
          self.print_board()
          self.play()
        end

        a = false
      else
        puts "Incorrect Choice...\n"
      end




    end




  end

  # end

  def color_input(times)
    i = 0
    while i <= times
      colors = ["red","blue","green","yellow","magenta","cyan"]
      puts "Color choice #{i+1} by the CodeMaker"
      colors.each_with_index do |value,key|
        print "#{key+1}-#{"•".colorize(:"#{value}")}  "
      end

      choice = gets.chomp.to_i
      if choice >= 1 && choice <= 6
        @code_generated.push(colors[choice-1])
        i+= 1
        # break
      else
        puts "Incorrect choice. Try Again..."
      end

    end

    system("cls")

  end

  def infos 
    puts "----- MASTERMIND GAME -----"
    puts "This is the MasterMind game made for the Odin Project"
    puts "Rules: If the color is good and the position is good a blue dot will be displayed"
    puts "Rules: If the color is good and the position is not good a white dot will be displayed"

  end

  def print_entire_line(array,line_number)
    # puts
    for i in 0..array[line_number].length-1 do
      print_hole(array[line_number][i])
    end
  end


  def print_board
    puts "       -----GameBoard-----"

    for i in 0..5 do 
      print ""
      print_entire_line(@code_breaker_playground,i)
      print " ---Breaker vs  Maker --- "
      print_entire_line(@code_maker_playground,i)

      puts " "
    end

  end


  def generate_code
    for i in 0..3
      self.code_generated.push(generate_color)
    end

  end

  def generate_color
    n = Random.new
    n = n.rand(0...100).to_i


    if n <= 15
      "red"
    elsif n > 15 && n <= 35
      "blue"
    elsif n > 35 && n <= 60
      "cyan"
    elsif n > 60 && n <= 75
      "magenta"
    elsif n > 50 && n <= 75
      "yellow"
    else
      "green"
    end
  end

  def enter_color

  end
  def correct_line(line_number)
    code_breaker_line = self.code_breaker_playground[line_number]
    code_maker_line = self.code_maker_playground[line_number]
    code = self.code_generated.clone
    win = false


    code_breaker_line.each_with_index do |value, key|
      if code.include?(value) == true
        elt_index = code.find_index(value)
        if key == elt_index 
          self.code_maker_playground[line_number].push("blue")
          code[elt_index] = "n"
        else
          self.code_maker_playground[line_number].push("white")
          code[elt_index] = "x"
          
        end
        win  = code.all?{ |element| element == code[0] }
      end
      
    end
    return win
  end

  def codebreaker_place_line(line_number)
    for i in 0..3
      self.code_breaker_playground[line_number][i] = codebreaker_place_color
      system("cls")
      self.print_board()
      
    end

    p self.code_breaker_playground[line_number]
    self.print_board

  end


  def play()
    i = 0
    win = false
    while i <= 5 && win == false
      codebreaker_place_line(i)
      system("cls")
      win = correct_line(i)
      print_board()
    
      if win == true
        puts "The word breaker won the game in #{i+1} turn!"
        return "win"
      end
      i += 1

    end

    puts "The word breaker lost the game..."
  end

  def codebreaker_place_color
    loop do 
      colors = ["red","blue","green","yellow","magenta","cyan"]
      puts "Color choice by the CodeBreaker"
      colors.each_with_index do |value,key|
        print "#{key+1}-#{"•".colorize(:"#{value}")}  "

      end

      puts " "

      choice = gets.chomp.to_i
      if choice >= 1 && choice <= 6
        return colors[choice-1]
        break
      else
        puts "Incorrect choice. Try Again..."
      end

    end

  end

end




Game = MasterMind.new
Game.start