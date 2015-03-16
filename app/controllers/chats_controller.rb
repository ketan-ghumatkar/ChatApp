class ChatsController < ApplicationController
  before_action :authenticate_user!

  def save_message
    @group = Group.find_by_id(params[:recipient_id])
    @message = Message.new(params[:content], params[:sender_id], params[:recipient_id])
    @sender = User.find_by_id(params[:sender_id]);
    @message.save
    
    pub_msg = { content: params[:content], sender: @sender.name }
    $redis.publish 'realtime_msg', { msg: pub_msg, recipient_user_ids: @group.users.collect(&:id)}.to_json
    render json: @message
  end

end
