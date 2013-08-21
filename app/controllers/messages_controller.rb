

class CreateFacebookMessage < Mutations::Command
  required do
    model :message
    string :text
  end
  
  def execute
    facebook_message = FacebookMessage.create!(inputs)
    facebook_message
  end
  
end

class CreateTumblrMessage < Mutations::Command
  required do
    model :message
    string :text
  end
  
  def execute
    tumblr_message = TumblrMessage.create!(inputs)
    tumblr_message
  end
  
end

class CreateMessage < Mutations::Command
  
  required do
    
    model :user
    
    #~ model :facebook_message do
      #~ string :text
    #~ end
    #~ model :linkedin_message do
      #~ string :text
    #~ end
    #~ model :tumblr_message do
      #~ string :text
    #~ end
    #~ model :twitter_message do
      #~ string :text
    #~ end
    #~ model :vkontakte_message do
      #~ string :text
    #~ end
    
  end
  
  optional do
  end
  
  def execute
    
    Rails.logger.debug "> "
    Rails.logger.debug "> "
    Rails.logger.debug "> "
    #~ Rails.logger.debug "> inputs: #{inputs.inspect}"
    #~ Rails.logger.debug "> inputs[][]: #{inputs[:facebook_message][:text]}"
    
    message = Message.create!(inputs)
    #~ message.build_texts(inputs)
    message.sent_at = Time.new
    
    message
  end
  
end

class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def create
    
    outcome = CreateMessage.run(params, user: current_user)
    
    if outcome.success?
    
      #~ outcome.result.build_texts(params)
      #~ outcome.result.save!
      
      Rails.logger.debug "> created: #{outcome.inspect}"
      flash[:info] = "> created: #{outcome.inspect}"
    else
      Rails.logger.debug ">"
      Rails.logger.debug "> not created: #{outcome.inspect}"
      flash[:error] = "> not created: #{outcome.inspect}"
    end
    
    Rails.logger.debug "> create messages controllere"
    Rails.logger.debug "> %s" % params.to_s
    
    #~ @message = current_user.messages.build
    #~ @message.build_texts(params)
    #~ 
    #~ if @message.save
      #~ flash[:success] = "message saved"
    #~ else
      #~ flash[:fail] = "message not saved"
    #~ end
    
    if outcome.success?
    
      @message = outcome.result
      
      facebook_message = CreateFacebookMessage.run(params[:facebook_message], message: @message)
      tumblr_message = CreateTumblrMessage.run(params[:tumblr_message], message: @message)
      
      #~ @message.facebook_message = facebook_message.result
      #~ @message.tumblr_message = tumblr_message.result
      #~ @message.save!
      
      ms_fb = MessageSendersExtra::MessageSenderFacebook.new(current_user)
      ms_ln = MessageSendersExtra::MessageSenderLinkedin.new(current_user)
      ms_tu = MessageSendersExtra::MessageSenderTumblr.new(current_user)
      ms_tw = MessageSendersExtra::MessageSenderTwitter.new(current_user)
      ms_vk = MessageSendersExtra::MessageSenderVkontakte.new(current_user)
      
      sent_statuses = Array.new
      
      sent_statuses << ms_fb.send_message(@message)
      sent_statuses << ms_ln.send_message(@message)
      sent_statuses << ms_tu.send_message(@message)
      sent_statuses << ms_tw.send_message(@message)
      sent_statuses << ms_vk.send_message(@message)
      
      sent_statuses = sent_statuses.join('; ')
      
      flash[:success] = "%s; sent with statuses: %s" % [flash[:success], sent_statuses]
      
      Rails.logger.debug "> sent statuses: %s" % sent_statuses
      
    end
    
    redirect_to root_url
  end
  
  def destroy
    @message.destroy
    redirect_to root_url
  end
  
  private
    
    def message_params
      params.require(:message).permit(:text)
    end
    
    
    def correct_user
      @message = current_user.messages.find_by(id: params[:id])
      redirect_to root_url if @message.nil?
    end

end
