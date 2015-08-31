class CreatorSerializer < ItemSerializer
  def media_type
    "Creator".downcase
  end
end
