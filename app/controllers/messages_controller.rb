
class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def create
    
    # TODO: контроль отправки, статусы.
    
    Rails.logger.debug "> MessagesController create"
    Rails.logger.debug "> message: %s" % @message
    
    outcome = CreateMessage.run(params, user: current_user)
    
    if outcome.success?
      
      @message = outcome.result
      
      MessageSendersExtra.create_submessages(params, @message)
      
      sent_statuses = MessageSendersExtra.send_messages(current_user, @message)
      
      flash[:success] = "%s; sent with statuses: %s" % [flash[:success], sent_statuses]
      flash[:info] = "> created: #{outcome.inspect}"
      
      Rails.logger.debug "> sent statuses: %s" % sent_statuses
      Rails.logger.debug "> created: #{outcome.inspect}"
      
      
    else
      Rails.logger.debug ">"
      Rails.logger.debug "> not created: #{outcome.inspect}"
      flash[:error] = "> not created: #{outcome.inspect}"
    end
    
    Rails.logger.debug "> create messages controllere"
    Rails.logger.debug "> %s" % params.to_s
    
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
