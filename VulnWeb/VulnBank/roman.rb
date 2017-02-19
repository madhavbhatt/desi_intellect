class Roman
  DIGITS = {
      'I' => 1,
      'C' => 100,
      'V' => 5,
      'D' => 500,
      'X' => 10,
      'M' => 1000,
      'L' => 50,
  }

  def roman_to_integer(roman_string)
    prev = nil
    roman_string.to_s.upcase.split(//).reverse.inject(0) do |running_sum, digit|
      if digit_value == DIGITS[digit]
        if prev && prev > digit_value
          running_sum -= digit_value
        else
          running_sum += digit_value
        end
        prev = digit_value
      end
      running_sum
    end
  end


  def method_missing(method)
    str = method.id2name()
    roman_to_integer(str)
  end
end

r = Roman.new
puts r.ii
puts r.xliv



