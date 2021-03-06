class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.delete(' ').delete("\r\n").length

    @word_count = @text.split.count

    @occurrences = @text.scan(/#{@special_word}/i).count

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    apr = @apr / 100
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (@principal * (apr / 12)) / (1 - 1 / (1 + (apr / 12)) ** (@years * 12))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = (@ending-@starting).seconds.abs
    @minutes = @seconds/60
    @hours= @minutes/60
    @days = @hours/24
    @weeks =@days/7
    @years = @weeks/52.1429

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @sorted_numbers.count

    @minimum = @sorted_numbers.min

    @maximum = @sorted_numbers.max

    @range = (@maximum-@minimum).abs

    if @count.odd?
      @median= @sorted_numbers[@count/2]
    else
      @median= (@sorted_numbers[@count/2]+@sorted_numbers[@count/2 - 1])/2
    end

    @sum = @sorted_numbers.sum

    @mean = @sum/@count

    @variance = []
      @sorted_numbers.each do |sort_num|
        @variance.push((sort_num - @mean)**2)
      end
    @variance= @variance.sum/@count

    @standard_deviation = (@variance**(0.5))

    @mode = Hash.new 0
      @sorted_numbers.each do |n_list|
        @mode[n_list] += 1
      end

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
