require_relative '../models/address_book'

class MenuController

  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - View Specific entry number"
    puts "6 - Exit"
    print "Enter your selection: "

    selection = gets.to_i
    puts "You picked #{selection}"

    case selection
    when 1
      system "clear"
      view_all_entries
      main_menu
    when 2
      system "clear"
      create_entry
      main_menu
    when 3
      system "clear"
      search_entries
      main_menu
    when 4
      system "clear"
      read_csv
      main_menu
    when 5
      system "clear"
      specific_entry
      main_menu
    when 6
      puts "Good-bye!"
      exit(0)
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
    end
  end

  def view_all_entries
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def create_entry
    system "clear"
    puts "New AdddressBoc Entry"
    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp
    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New Entry created"
  end

  def search_entries
  end

  def read_csv
  end

  def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp

    case selection
    when "n"
    when "d"
    when "e"
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entry_submenu(entry)
    end
  end

  def specific_entry
    entries = address_book.entries
    print "Please enter the specific menu number you want to view: "
    input = gets.chomp.to_i

    # check if the user input a number in the correct range
      if(input <= entries.count && input > 0)
    # if the number is in the correct range, output the entry
        print entries[input-1]
    # if the number is not in the correct range, tell them the range,
      elsif (entries.count == 0)
        puts "There are no entries yet."
        puts "Please choose 'Create an entry', enter some data, and try again"
        puts ""
      else
        puts "There is no entry ##{input}"
        puts ""
        if(entries.count == 1)
          puts "There's only 1 entry, choose that one"
          puts ""
        else
          puts "Choose an entry between 1 - #{entries.count}"
          puts ""
          system "clear"
          specific_entry
        end
      end
    # and ask them to try again
  end

end
