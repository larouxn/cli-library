class Book
  attr_reader :title, :author, :bookmark, :status

  def initialize(title, author)
   @title = title
   @author = author
   @bookmark = "none"
   @status = "unread"
  end

  def place_bookmark(page_number)
    @bookmark = page_number
  end

  def read
    @status = "read"
  end

  def to_s
    puts "#{@title} by #{@author}, bookmark: #{@bookmark}, status: #{@status}"
  end
end
