(1..100).each do |i|
  if (i % 3).zero? && (i % 5).zero
    puts 'FizzBuzz'
  elsif (i % 3).zero? # 3の倍数のとき
    puts 'Fizz'
  elsif (i % 5).zero? # 5の倍数のとき
    puts 'Buzz'
  else # それ以外のとき
    puts i
  end
end
