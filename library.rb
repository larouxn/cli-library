#!/usr/bin/env ruby

library = File.new("library.txt", "w+")

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
  exit
end

def add
end

def read
end

def show
end

def quit
  library.close
  # execute ctrl-c, ctrl-d, exit command
end
