class BookQuerier
  def initialize
    @client = Goodreads::Client.new(Goodreads.configuration)
  end

  def search_by_book_name(name)
    client.search_books(name)
  end

  def search_by_book_id(external_id)
    client.book(external_id)
  end

  def search_by_author_name(name)
    client.author_by_name(name)
  end

  def search_by_author_id(external_id)
    client.author(external_id)
  end

  private

  attr_reader :client
end
