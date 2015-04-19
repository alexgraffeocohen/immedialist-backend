class MediaSerializer < ItemSerializer
  def media_type
    object.class.name
  end
end
