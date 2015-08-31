class MediaSerializer < ItemSerializer
  def media_type
    object.class.name.downcase
  end
end
