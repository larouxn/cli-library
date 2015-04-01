#!/usr/bin/env ruby

require 'digest/sha1'

### TO DO
## Cleanup hashing
## Cleanup show regex
## To class or not class library

@library = {}

def hash_title(title)
  (Digest::SHA1.hexdigest(title)).to_sym
end

def add(title, author)
  hash = hash_title(title)
  if @library.has_key?(hash)
    puts "Book is already in your library"
  else
    @library[hash] = [title, author, "unread"]
    puts "Added #{title} by #{author}"
  end
end

def read(title)
  hash = hash_title(title)
  if @library[hash][2] == "read"
    puts "Book is already marked as read"
  else
    @library[hash][2] = "read"
    puts "You've read #{title}!"
  end
end

def show(all_or_unread, author = nil)
  if author == nil
    case all_or_unread
    when "all"
      @library.each do |key, array|
        puts "#{array[0]} by #{array[1]} \(#{array[2]}\)"
      end
    when "unread"
      @library.each do |key, array|
        if array[2] == "unread"
          puts "#{array[0]} by #{array[1]} \(#{array[2]}\)"
        end
      end
    end
  else
    puts "Here's #{all_or_unread} by #{author}"


  end
end

def quit
  puts "Take care and have a great day!"
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
end

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
    puts "Command not recognized, please use 'help' for a list of available commands"
  end
end
