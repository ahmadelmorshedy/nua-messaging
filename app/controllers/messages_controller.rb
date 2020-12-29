class MessagesController < ApplicationController

  def index
    if params[:source] == 'outbox'
      @messages = User.current.outbox.messages.paginate(page: params[:page])
      @messages_source = 'Outbox'
    else
      @messages = User.current.inbox.messages.paginate(page: params[:page])
      @messages_source = 'Inbox'
    end
  end

  def show
    @message = Message.find(params[:id])
    @message.mark_as_read
    @messages_source = params[:source]
  end

  def new
    @message = Message.new
  end

  def create
    begin
      Message.create_message(messages_params[:body],
                            User.default_doctor,
                            User.current)
      flash[:notice] = 'Message sent successfully'
      redirect_to messages_path
    rescue Exception => _e
      flash.now[:alert] = 'Something went wrong - unable to create message'
      @message = Message.new
      render 'new'
    end
  end

  private

  def messages_params
    params[:message].permit(:body)
  end
end
