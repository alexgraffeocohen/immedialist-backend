module Helpers
  def category_names_for(model)
    model.categories.map(&:name)
  end

  def call_query_with_cassette(vcr_cassette)
    VCR.use_cassette(vcr_cassette) do
      query.call
    end
  end
end
