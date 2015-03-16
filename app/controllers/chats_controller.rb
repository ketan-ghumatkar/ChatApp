class ChatsController < ApplicationController
  before_action :authenticate_user!

  def save_message
    @group = Group.find_by_id(params[:recipient_id])
    @sender = User.find_by_id(params[:sender_id]);
    @message = Message.new(params[:content], params[:sender_id], params[:recipient_id])
    @message.save
    
    pub_msg = { content: params[:content], sender: @sender.name }
    $redis.publish 'realtime_msg', { msg: pub_msg, recipient_user_ids: @group.users.collect(&:id)}.to_json
    render json: @message.to_json
  end

  def show
    messages = $redis.smembers "group:#{params[:id]}"
    resp = messages.map do |m| 
      jm = JSON.parse(m);
      sender = User.find_by_id(jm['sender_id'])
      { content: jm['content'], sender: sender.name }
    end
    render json: resp.to_json
  end

end
