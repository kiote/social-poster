class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def create
    
    outcome = CreateMessage.run(params, user: current_user)
    
    if outcome.success?
      
      MessageSendersExtra.do_send_message(outcome.result)
      
      flash[:success] = "message is sent"
    else
      flash[:error] = "message is not sent"
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
      @message = current_user.messages._by(id: params[:id])
      redirect_to root_url if @message.nil?
    end

end
