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


    text_wo_spaces = @text.gsub(" ", "")
    text_wo_linefeed = text_wo_spaces.gsub("ln","")
    text_wo_cr = text_wo_linefeed.gsub("\r","")
    text_wo_tabs = text_wo_cr.gsub("\t","")
    @character_count_without_spaces = text_wo_tabs.length

    words = @text.split
    @word_count = words.count

    #words.count(@special_word)
    text_downcase = @text.downcase
    text_down_no_punc = text_downcase.gsub(/[^a-z0-9\s]/i, "")
    down_text_array = text_down_no_punc.split
    @occurrences = down_text_array.count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    @monthly_payment = ((((@apr/100)/12) * @principal) / (1 - (1 + ((@apr/100)/12)) ** ( -(@years * 12))))


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
    # want to make sure that the difference between starting and ending times are always positive, so need to use an if/else setup to make that happen. ALWAYS END WITH AN 'END'!!!

    if @starting > @ending
      @seconds = @starting - @ending
    else @seconds = @ending - @starting
    end

    # great - now let's use seconds to determine calcs for min/hour/day/week/yr
    @minutes = @seconds/60

    @hours = @seconds/3600

    @days = @seconds/86400

    @weeks = @seconds/604800

    @years = @seconds/(31536000)
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

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum


    #MEDIAN
    #find the median
    #first sort
    sorted = @numbers.sort

    #ARRAYS start at 0!
    #if the array is an odd length
    if sorted.length % 2 != 0
      #the median is the slot in the array that is one more than the total number of slots, divided by 2
      @median = sorted[((sorted.length+1)/2)-1]
      #if the array is an even length
    else @median =  (sorted[(sorted.length/2)-1] + sorted[sorted.length/2])/2
      #add up the two middle numbers and divide that sum by 2 to find the median
    end
    #@median = def median(@sorted_numbers)
    #for even lengthed arrays, we need 1) the length divided by 2, plus 1 (because it starts at 0); 2) the length plus 2, divided by 2, then plus one (because it starts at 0)

    #SUM
    @sum = @numbers.sum

    #MEAN
    @mean = @sum/@count

    #VARIANCE
    squared_difference_array = []            # Create an empty array

    @numbers.each do |num|       # For each element in numbers, (refer to it as "num")
      squared_difference = (num-@mean) * (num-@mean)            # Square the number
      squared_difference_array.push(squared_difference)  # Push it into the squared_numbers array
    end

    @variance = (squared_difference_array.sum)/@numbers.count  # Sum the squares

    #STANDARD DEVIATION
    @standard_deviation = @variance**(0.5)

    #square root of the variance found above

    #MODE
    frequency_array = []
    @numbers.each do |num|       # For each element in numbers, (refer to it as "num")
      frequency = @numbers.count(num)   # Count how many times that number appears in the array
      frequency_array.push(frequency)  # Push it into the frequency array
    end

    #find the maximum number in the frequency array
    max = frequency_array.max

    #find what position it is in
    position = frequency_array.index(max)

    #produce the number from @numbers that corresponds to that position
    @mode=@numbers[position]




    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
