#!/usr/bin/env ruby
require 'tempfile'

def help
  puts <<-help
  Usage: ruby library.rb

  Commands:
  - **add "$title" "$author"**: adds a book to the library with the given title and author. All books are unread by default.
  - **read "$title"**: marks a given book as read.
  - **show all**: displays all of the books in the library
  - **show unread**: display all of the books that are unread
  - **show all by "$author"**: shows all of the books in the library by the given author.
  - **show unread by "$author"**: shows the unread books in the library by the given author
  - **quit**: quits the program.
  help
end

def add(title, author)
  puts "Added #{title} by #{author}"
  # semi-persistent data code
end

def read(title)
  puts "#{title} marked as read"
  # semi-persistent data code
end

def show (all_or_unread, by, author)
  # multiple optional arguments, case based on what the arguments are
  case all_or_unread
  when "all"
    # beep
  when "unread"
    # boop
  else
    puts "Improper arguments"
  end
  # semi-persistent data code
end

def quit
  exit
end

library = Tempfile.new("library.txt")

begin
  loop do
    print ">> "

    begin
      line = $stdin.gets.chomp
    rescue NoMethodError, Interrupt
      exit
    end

    # Capture imput, format it, and send it to methods
    case line
    when /^help$/
      help
    when /^add "{1}.*?"{1} "{1}.*?"{1}$/
      line = line.scan(/"{1}.*?"{1}/)
      add(line[0], line[1])
    when /^read .+$/
      puts "WILL BE USED TO SET READ FLAGS"
    when /^show .+$/
      puts "WILL BE USED TO LIST BOOKS"
    when /^(quit|exit)$/
      quit
    when ""
    else
      puts "Command not recognized, please use 'help' for a list of available commands"
    end
  end
ensure
  puts ""
  library.close
  library.unlink
end
