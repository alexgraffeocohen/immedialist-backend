class TestQuery
  include FactoryGirl::Syntax::Methods
  include Immedialist::ItemTypeConversion

  def self.call_with_real_name
    new.call_real_name_query
  end

  def self.call_with_fake_name
    new.call_fake_name_query
  end

  def self.call_with_real_id
    new.call_real_id_query
  end

  def self.call_with_fake_id
    new.call_fake_id_query
  end

  private

  attr_accessor :query

  def query_class
    Query.const_get(self.to_item_type.name)
  end

  def call_query_with_cassette(vcr_cassette)
    VCR.use_cassette(vcr_cassette) do
      query.call
    end
  end
end
