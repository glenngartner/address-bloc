def greeting
    greeting_type = ARGV[0].downcase.capitalize
    array = ARGV.drop(1)
  array.each do |arg|
    puts "#{greeting_type} #{arg.downcase.capitalize}"
  end
end

greeting
