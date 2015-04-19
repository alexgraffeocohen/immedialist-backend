class RequestedItemSerializer < ItemSerializer
  # FIXME: I feel like this is unecessary, but I'm unsure of the consequences
  # of taking up #media_type right now
  def media_type
    object.media_name
  end
end
