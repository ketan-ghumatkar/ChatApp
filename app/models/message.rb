class Message
  def initialize(content, sender_id, recipient_id)
  	@content = content
  	@sender_id = sender_id
  	@recipient_id = recipient_id
  end

  def save
    $redis.sadd "group:#{ @recipient_id }", self.to_json
  end

  def find_by_group_id(id)
    $redis.smembers "group:{ id }"
  end
end
