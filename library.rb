#!/usr/bin/env ruby

###############################
# Nicholas La Roux            #
# April 2015                  #
# Command line personal       #
# library management utility  #
###############################

require 'yaml'
require_relative 'book'

def load_library
  storage = File.open('my_library.yaml', 'a+')
  if File.size(storage) == 0
    @library = []
  else
    @library = YAML.load(File.read(storage))
  end
end

def save_library
  File.open('my_library.yaml', 'w+') {|f| f.write(YAML.dump(@library))}
end

def retrieve_book(title, author)
  @library.each do |book|
    next unless book.title == title && book.author == author
    return book
  end
  return false
end

def add_book_to_library(title, author)
  @library << Book.new(title, author) unless retrieve_book(title, author)
  puts "Added #{@title} by #{@author} to your library."
end

def read(title, author)
  if retrieve_book(title, author)
    book = retrieve_book(title, author)
    if book.status == "read"
      "Book is already marked as read."
    else book.read
      puts "#{@title} by #{@author} has been marked as read."
    end
  else
    "That book is not in your library."
  end
end

def remove_book_from_library(title, author)
  if retrieve_book(title, author)
    book = retrieve_book(title, author)
    @library.delete(book)
    puts "Removed #{@title} by #{@author} from your library."
  else
    "That book is not in your library."
  end
end

def show(all_or_unread, author = nil)
  if @library.size == 0
    puts "Your library is empty."
  else
    @library.each do |book|
      if all_or_unread == "unread" and author
        puts book if book.status == "unread" && book.author == author
      elsif all_or_unread == "unread"
        puts book if book.status == "unread"
      elsif author
        puts book if book.author == author
      else
        puts book
      end
    end
  end
end

def quit
  save_library
  puts "Bye!"
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

puts "Welcome to your library!"
load_library

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
    add_book_to_library(line[0], line[1])
  when /^remove "{1}.*?"{1} "{1}.*?"{1}$/
    line = line.scan(/"{1}.*?"{1}/)
    remove_book_from_library(line[0], line[1])
  when /^read "{1}.*?"{1} "{1}.*?"{1}$/
    line = line.scan(/"{1}.*?"{1}/)
    # line[1] = line[1].tr('"', '')
    read(line[0], line[1])
  # when /^read "{1}.*?"{1}$/
  #   line = line.scan(/"{1}.*?"{1}/)
  #   read(line[0], line[1])
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
    puts "Command not recognized, please use 'help' for a list of available commands"
  end
end
