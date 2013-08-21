

class CreateFacebookMessage < Mutations::Command
  required do
    model :message
    string :text
  end
  
  def execute
    
  end
end

class CreateMessage < Mutations::Command
  
  required do
    model :user
  end
  
  optional do
  end
  
  def execute
  
    message = Message.create!(inputs)
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
    
      outcome.result.build_texts(params)
      outcome.result.save!
      
      Rails.logger.debug "> created: #{outcome.result.inspect}"
      flash[:info] = "> #{outcome.result.inspect} created"
    else
      Rails.logger.debug "> #{outcome.result.inspect} not created"
      flash[:error] = "> #{outcome.result.inspect} not created"
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
    
    if not outcome.success?
      redirect_to root_url
    end
    
    @message = outcome.result
    
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
