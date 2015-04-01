class Book
  attr_reader :title, :author, :status

  def initialize(title, author)
   @title = title
   @author = author
   @status = "unread"
  end

  def read
    @status = "read"
  end
end
