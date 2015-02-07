class TestQuery
  include FactoryGirl::Syntax::Methods
  include Immedialist::ItemTypeConversion

  def call_with_real_name
    self.query = query_class.new(name: real_name)
    call_query_with_cassette(real_name_cassette)
  end

  def call_with_fake_name
    self.query = query_class.new(name: fake_name)
    call_query_with_cassette(fake_name_cassette)
  end

  def call_with_real_id
    self.query = query_class.new(external_id: real_external_id)
    call_query_with_cassette(real_id_cassette)
  end

  def call_with_fake_id
    self.query = query_class.new(external_id: fake_external_id)
    call_query_with_cassette(fake_id_cassette)
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
