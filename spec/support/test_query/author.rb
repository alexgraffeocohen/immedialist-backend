require 'support/test_query'

class TestQuery::Author < TestQuery
  def initialize
    @real_author = build(:real_author)
    @fake_author = build(:fake_author)
    super
  end

  private

  attr_reader :real_author, :fake_author

  def real_name
    real_author.name
  end

  def fake_name
    fake_author.name
  end

  def real_external_id
    real_author.goodreads_id
  end

  def fake_external_id
    fake_author.goodreads_id
  end
end
