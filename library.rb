#!/usr/bin/env ruby

### TO DO
#[X]# Cleanup hashing
#[]# Cleanup show regex
#[X]# To class or not class library
#[O]# Cleanup show method

## Test data
# @library = {
#   :"Moby Dick" => ["Moby Dick", "Dingle", "unread"],
#   :"Moby Dick2" => ["Moby Dick2", "Dingle2", "read"],
# }

@library = {}

def print_to_console(message)
  puts "\n#{message}"
  puts "\n"
end

def print_book(array)
  puts "#{array[0]} by #{array[1]} \(#{array[2]}\)"
end

def add(title, author)
  key = title.downcase.to_sym
  if @library.has_key?(key)
    print_to_console("That book is already in your library.")
  else
    @library[key] = [title, author, "unread"]
    print_to_console("Added #{title} by #{author}")
  end
end

def read(title)
  key = title.downcase.to_sym
  if @library.has_key? key
    if @library[key][2] == "read"
      print_to_console("#{title} is already marked as read.")
    else
      @library[key][2] = "read"
      print_to_console("You've read #{title}!")
    end
  else
    print_to_console("#{title} is not in your library.")
  end
end

# Could use some refactoring
def show(all_or_unread, author = nil)
  puts "\n"
  if @library.size == 0
    puts "Your library is empty."
  elsif author == nil
    case all_or_unread
    when "all"
      @library.each do |key, array|
        print_book(array)
      end
    when "unread"
      number_of_unread = 0
      @library.each do |key, array|
        if array[2].to_s == "unread"
          print_book(array)
          number_of_unread += 1
        end
      end
      if number_of_unread == 0
        puts "All books have already been read."
      end
    end
  else
    case all_or_unread
    when "all"
      books_by_author = 0
      @library.each_pair do |key, array|
        if array[1].downcase == author.downcase.tr('"', '')
          print_book(array)
          books_by_author += 1
        end
        if books_by_author == 0
          puts "You do not have any books by that author."
        end
      end
    when "unread"
      books_by_author = 0
      @library.each do |key, array|
        if array[1].downcase == author.downcase.tr('"', '') && array[2].to_s == "unread"
          print_book(array)
          books_by_author += 1
        end
        if books_by_author == 0
          puts "You've already read all of your books by #{array[1]}."
        end
      end
    end
  end
  puts "\n"
end

def quit
  print_to_console("\nBye!")
  exit
end

def help
  puts <<-help
  Usage: ruby library.rb

  Commands:
  - add "title" "author"      Adds a book to the library with the given title and author. All books are unread by default.
  - read "title"              Marks a given book as read.
  - show all                  Displays all of the books in the library.
  - show unread               Display all of the books that are unread.
  - show all by "author"      Shows all of the books in the library by the given author.
  - show unread by "author"   Shows the unread books in the library by the given author.
  - quit                      Quits the program.
  help

  puts "\n"
end

print_to_console("Welcome to your library!")

loop do
  print "> "

  begin
    line = $stdin.gets.chomp
  rescue NoMethodError, Interrupt
    exit
  end

  # Capture input, format it, and send it to methods
  case line
  when /^help$/
    help
  when /^add "{1}.*?"{1} "{1}.*?"{1}$/
    line = line.scan(/"{1}.*?"{1}/)
    line[1] = line[1].tr('"', '')
    add(line[0], line[1])
  when /^read "{1}.*?"{1}$/
    line = line.scan(/"{1}.*?"{1}/)
    read(line[0])
  when /^show (all|unread)\s?(by "{1}.*?"{1})?$/
    line = line.scan(/(all|unread)|("{1}.*?"{1})/)
    if line[1] == nil # basic
      show(line[0][0])
    else # with author
      show(line[0][0], line[1][1])
    end
  when /^(quit|exit)$/
    quit
  when ""
  else
    puts "\nCommand not recognized, please use 'help' for a list of available commands"
    puts "\n"
  end
end
