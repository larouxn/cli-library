#!/usr/bin/env ruby

#####################################
# Nicholas La Roux                  #
# April 3 2015                      #
# Etsy Code Challenge               #
# Create command line personal      #
# library management utility        #
#####################################

require 'yaml'

@library = {}
@printed = false

def load_library
  YAML.load(File.read('library.yaml'))
end

def save_library
  File.open('library.yaml', 'w') {|f| f.write(YAML.dump(library))}
end

# Helper methods
def print_to_console(message, breaks = true)
  if breaks
    puts "\n#{message}"
    puts "\n"
  else
    puts message
  end
  @printed = true
end

def format_book(array)
  "#{array[0]} by #{array[1]} \(#{array[2]}\)"
end

def create_key(value)
  key = value.downcase.to_sym
end

# Main methods
def add(title, author)
  key = create_key(title)
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

def show(all_or_unread, author = nil)
  puts "\n"
  number_of_unread = 0
  number_of_books_by_author = 0
  @printed = false

  if @library.size == 0
    print_to_console("Your library is empty.", false)
  else
    @library.each do |key, array|
      if author && all_or_unread == "unread" && array[1].downcase == author.downcase.tr('"', '') && array[2].to_s == "unread" # show unread by author
        print_to_console(format_book(array), false)
        number_of_books_by_author += 1
        number_of_unread += 1
      elsif author && all_or_unread == "unread" && array[1].downcase == author.downcase.tr('"', '')
        number_of_books_by_author += 1 # Not perfect, used for show unread by author, when all books by that author have been read
      elsif author && all_or_unread == "all" && array[1].downcase == author.downcase.tr('"', '') # show all by author
        print_to_console(format_book(array), false)
        number_of_books_by_author += 1
      elsif author == nil && all_or_unread == "unread" && array[2].to_s == "unread" # show unread
        print_to_console(format_book(array), false)
        number_of_unread += 1
      elsif author == nil && all_or_unread == "all" # show all
        print_to_console(format_book(array), false)
      end
    end

    if @printed == false
      if author && number_of_books_by_author != 0 && number_of_unread == 0
        print_to_console("You've already read all of your books by that author.", false)
      elsif author && number_of_books_by_author == 0
        print_to_console("You do not have any books by that author.", false)
      elsif author == nil && number_of_unread == 0
        print_to_console("All books have already been read.", false)
      end
    end
  end
  puts "\n"
end

def quit
  print_to_console("Bye!")
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

  # Capture input
  begin
    line = $stdin.gets.chomp
  rescue NoMethodError, Interrupt
    exit
  end

  # Decipher input, format it, and send it to methods
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
    print_to_console("Command not recognized, please use 'help' for a list of available commands")
  end
end
