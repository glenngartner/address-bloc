require_relative '../models/address_book'

class MenuController

  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    #system "clear"
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    puts "! - the nuclear option"
    print "Enter your selection: "

    selection = gets.chomp
    puts "You picked #{selection}"

    case selection
    when "1"
      system "clear"
      view_all_entries
      main_menu
    when "2"
      system "clear"
      create_entry
      main_menu
    when "3"
      system "clear"
      search_entries
      main_menu
    when "4"
      system "clear"
      read_csv
      main_menu
    when "5"
      puts "Good-bye!"
      exit(0)
    when "!"
      the_nuclear_option
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
    print "Search by name: "
    name = gets.chomp

    match = address_book.binary_search(name)
    system "clear"

    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def read_csv
    print "Enter CSV file to import: "
    file_name = gets.chomp

    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
     rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
     end
  end

  def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    puts "! - the nuclear option"

    selection = gets.chomp

    case selection
    when "n"
    when "d"
      delete_entry(entry)
    when "e"
      edit_entry(entry)
      entry_submenu(entry)
    when "m"
      system "clear"
      main_menu
    when "!"
      the_nuclear_option
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entry_submenu(entry)
    end
  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def the_nuclear_option
    are_there_are_entries_to_nuke?
    system "clear"

    puts "This wipes out everyone in your list."
    puts ""
    puts "Every last one..."
    puts ""
    puts "Man, woman, and child..."
    puts ""
    puts "Do you want to continue?!? (y/n)"
    answer = gets.chomp
    answer_check(answer)
    system "clear"

    puts "Are you sure? (y/n)"
    answer = gets.chomp
    answer_check(answer)
    system "clear"

    puts "No, you're not sure..."
    puts ""
    puts "Really?!? (y/n)"
    answer = gets.chomp
    answer_check(answer)
    system "clear"

    puts "Sounds like you are."
    puts ""
    puts "Continue? (y/n)"
    answer = gets.chomp
    answer_check(answer)
    system "clear"

    puts "All of 'em? (y/n)"
    answer = gets.chomp
    answer_check(answer)
    system "clear"

    #puts "But you really liked #{address_book.entries[0].name}"
    random_friend = random_name_yank
    puts "But you really liked #{random_friend}"
    puts ""
    puts "Nuke #{random_friend}?!? (y/n)"
    answer = gets.chomp
    answer_check(answer)
    system "clear"

    random_friend2 = random_name_yank
    puts "But #{random_friend2} baked you that cake on your birthday"
    puts ""
    puts "Still? Remembering #{random_friend2}?!? (y/n)"
    answer = gets.chomp
    answer_check(answer)
    system "clear"

    puts ""
    puts "You're heartless. Please confirm (y/n)"
    answer = gets.chomp
    answer_check(answer)
    system "clear"

    puts ""
    puts "Fine. I'll do as you say."
    puts ""
    puts "('Enter' to continue. I'll save you the trouble of reaching for 'y')"
    dramatic_pause
    puts "line em up."
    puts "(Enter to continue)"
    puts ""
    gets.chomp

    first_sass = true
    first_time = "You know the drill... enter..."
    address_book.entries.each do |victim|
      puts "Goodbye, #{victim.name}"
      if(first_sass == true)
        puts first_time
      else
        puts "enter..."
      end
      first_sass = false
      gets.chomp
    end

    address_book = []
    system "clear"
    puts "blinding light"
    puts "enter, again..."
    dramatic_pause
    puts "mushroom cloud"
    puts "keep it up..."
    dramatic_pause
    puts "........."
    dramatic_pause
    puts "that meant silence, btw"
    dramatic_pause
    puts "except for your keystrokes..."
    dramatic_pause
    puts "echoing in your ears"
    dramatic_pause
    puts "sitting there."
    dramatic_pause
    puts "alone..."
    dramatic_pause
    puts "Because you now have #{address_book.entries.count} friends in the whole world"
    dramatic_pause
    puts "After you nuked your address book"
    dramatic_pause
    puts "Except me, the only survivor"
    dramatic_pause
    puts "But I'm not your friend"
    gets.chomp
    system "clear"
    main_menu
  end

  def dramatic_pause
    puts ""
    gets.chomp
    puts ""
    system "clear"
  end

  def are_there_are_entries_to_nuke?
    if (address_book.entries.count > 0)
      return
    else
      system "clear"
      puts ""
      puts "There's no one to nuke"
      puts "First, make friends"
      puts "Then, add them to your list"
      puts "Then, you can nuke all the friends on your list"
      puts ""
      puts "Press Enter to return to the Main Menu"
      gets.chomp
      system "clear"
      main_menu
    end
  end

  def random_name_yank
    index = rand(address_book.entries.count-1)
    return address_book.entries[index].name
  end

  def answer_check(answer)
    case answer
      when "y"
        return
      when "n"
        system "clear"
        puts ""
        puts "Great"
        puts ""
        puts "I knew you were sane"
        puts "Press Enter to return to the Main Menu"
        dramatic_pause
        main_menu
      else
        system "clear"
        puts ""
        puts "well, that's not a 'y', or a 'n'... given the gravity of this situation, I'll count that as a 'no'"
        puts ""
        puts "Press Enter to return to the Main Menu..."
        dramatic_pause
        puts "Returning to return to the Main Menu "
        main_menu
    end
  end

  def edit_entry(entry)
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp

    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"

    puts "Updated entry:"
    puts entry
  end

  def search_submenu(entry)
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp

    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  end

end
