class MessagesController < ApplicationController

  def index
    if params[:source] == 'outbox'
      @messages = User.current.outbox.messages
      @messages_source = 'Outbox'
    else
      @messages = User.current.inbox.messages
      @messages_source = 'Inbox'
    end
  end

  def show
    @message = Message.find(params[:id])
    @messages_source = params[:source]
  end

  def new
    @message = Message.new
  end

  def create
    if Message.create_message(messages_params[:body],
                              User.default_doctor,
                              User.current)
      flash[:notice] = 'Message sent successfully'
      redirect_to messages_path
    else
      flash[:alert] = 'Something went wrong - unable to create message'
      render 'new'
    end
  end

  private

  def messages_params
    params[:message].permit(:body)
  end
end
