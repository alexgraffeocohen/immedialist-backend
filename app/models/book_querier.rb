class BookQuerier
  def initialize
    @client = Goodreads::Client.new(Goodreads.configuration)
  end

  def search_by_book_title(title)
    client.search_books(title)
  end

  def search_by_book_id(external_id)
    client.book(external_id)
  end

  private

  attr_reader :client
end
