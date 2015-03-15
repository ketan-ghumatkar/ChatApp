class ChatsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    Thread.new do
      @redis = Redis.new()
      @redis.subscribe 'messages' do |on|
        on.message do |channel, msg|
          logger.info "###{channel} - [#{data}"
        end
      end
    end
  end

  def save_message
    @group = Group.find_by_id(params[:recipient_id])
    @redis = Redis.new
    @message = Message.new(params[:content], params[:sender_id], params[:recipient_id])
    if @message.save
        @redis.publish 'messages', @messages.to_json
        # redirect_to chats_path
        render json: @message
    else
      error = { success: false, message: "MESSAGE_FAILURE" }
      render json: error.to_json
    end  
  end

end
