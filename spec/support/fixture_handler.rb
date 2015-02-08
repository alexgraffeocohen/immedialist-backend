class FixtureHandler
  def initialize(model_name)
    @model_name = model_name.downcase
  end

  def real_name_fixture
    "real_name_#{model_name}_query"
  end

  def fake_name_fixture
    "fake_name_#{model_name}_query"
  end

  def real_id_fixture
    "real_id_#{model_name}_query"
  end

  def fake_id_fixture
    "fake_id_#{model_name}_query"
  end

  private

  attr_reader :model_name
end
