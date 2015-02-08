class TestQuery
  include FactoryGirl::Syntax::Methods
  include Immedialist::ItemTypeConversion

  delegate :real_name_fixture, :fake_name_fixture, :real_id_fixture,
    :fake_id_fixture, to: :fixture_handler

  def initialize
    @fixture_handler = FixtureHandler.new(item_type_name)
  end

  def call_with_real_name
    self.query = query_class.new(name: real_name)
    call_query_with_fixture(real_name_fixture)
  end

  def call_with_fake_name
    self.query = query_class.new(name: fake_name)
    call_query_with_fixture(fake_name_fixture)
  end

  def call_with_real_id
    self.query = query_class.new(external_id: real_external_id)
    call_query_with_fixture(real_id_fixture)
  end

  def call_with_fake_id
    self.query = query_class.new(external_id: fake_external_id)
    call_query_with_fixture(fake_id_fixture)
  end

  private

  attr_accessor :query
  attr_reader :fixture_handler

  def item_type_name
    self.to_item_type.name
  end

  def query_class
    Query.const_get(item_type_name)
  end

  def call_query_with_fixture(fixture_name)
    VCR.use_cassette(fixture_name) do
      query.call
    end
  end
end
