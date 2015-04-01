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

def add
end

def read
end

def show
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

    case line
    when /help/
      help
    when /^add .+ .+/
      puts "WILL BE USED TO ADD BOOKS"
    when /^read .+/
      puts "WILL BE USED TO SET READ FLAGS"
    when /^show all/
      puts "WILL BE USED TO LIST BOOKS"
    when /^show unread/
      puts "WILL BE USED TO LIST BOOKS"
    when /^show all by .+/
      puts "WILL BE USED TO LIST BOOKS"
    when /^show unread by .+/
      puts "WILL BE USED TO LIST BOOKS"
    when /quit/
      quit
    when ""
    else
      puts "Command not recognized, please use 'help' for a list of available commands"
    end

    # if from_stdin
    #   run = "echo \"%s\" | #{command}" % [ line, nil ]
    # else
    #   run = "#{command} %s" % [ line, nil ]
    # end
    # puts "$ #{run}" if debug
    # system run
    # warn "Use Ctrl-D (i.e. EOF) to exit" if line =~ /^(exit|quit)$/
  end
ensure
  puts ""
  library.close
  library.unlink
end
