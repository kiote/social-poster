class MessagesController < ApplicationController
  
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
  
  def create
    
    params[:facebook_message][:text] = params[:facebook_message][:text].sub("<br>", "")
    params[:linkedin_message][:text] = params[:linkedin_message][:text].sub("<br>", "")
    params[:twitter_message][:text] = params[:twitter_message][:text].sub("<br>", "")
    params[:vkontakte_message][:text] = params[:vkontakte_message][:text].sub("<br>", "")
    
    outcome = CreateMessage.run(params, user: current_user)
    
    @send_results = {}
    
    if outcome.success?
      
      @message = outcome.result
      
      @send_results = MessageSendersExtra.do_send_message(@message)
      
      flash[:success] = "message is sent"
    else
      flash[:error] = "message is not sent"
    end
    
    # redirect_to root_url
  end
  
  def destroy
    @message.destroy
    redirect_to root_url
  end
  
  def show
    
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
