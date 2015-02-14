require 'support/test_query'

class TestQuery::Book < TestQuery
  def initialize
    @real_book = build(:real_book)
    @fake_book = build(:fake_book)
    super
  end

  private

  attr_reader :real_book, :fake_book

  def real_name
    real_book.name
  end

  def fake_name
    fake_book.name
  end

  def real_external_id
    real_book.goodreads_id
  end

  def fake_external_id
    fake_book.goodreads_id
  end
end
