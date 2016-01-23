class APIResource
  def self.find(id)
    new(id).find
  end

  def find
    raise NotImplementedError
  end

  def attributes
    {}.tap do |hash|
      active_attributes.each do |attribute|
        hash[attribute] = self.send(attribute)
      end
    end
  end

  private

  def active_attributes
    raise NotImplementedError
  end
end
