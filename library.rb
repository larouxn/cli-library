#!/usr/bin/env ruby
require 'tempfile'

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

def add(title, author)
  puts "Added #{title} by #{author}"
  # semi-persistent data code
end

def read(title)
  puts "Marked #{title} as read"
  # semi-persistent data code
end

def show (all_or_unread, author = nil)
  # multiple optional arguments, case based on what the arguments are
  if author == nil
    puts "Here's #{all_or_unread}"
  else
    puts "Here's #{all_or_unread} by #{author}"
  end


  # case all_or_unread
  # when "all"
  #   # beep
  # when "unread"
  #   # boop
  # else
  #   puts "Improper arguments"
  # end
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
ensure
  puts ""
  library.close
  library.unlink
end
