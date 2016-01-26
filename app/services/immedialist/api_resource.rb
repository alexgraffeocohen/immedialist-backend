module Immedialist
  class APIResource
    def self.find(id)
      new({id: id}).find
    end

    def find
      @query_result = query_api
      compare_results_to_api_expectations!
      self
    end

    def attributes
      {}.tap do |hash|
        active_attributes.each do |attribute|
          hash[attribute] = self.send(attribute)
        end
      end
    end

    private

    def compare_results_to_api_expectations!
      raise NotImplementedError
    end

    def active_attributes
      raise NotImplementedError
    end
  end
end
