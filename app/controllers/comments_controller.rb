class CommentsController < ApplicationController  
  def create
    event = Event.find(params[:event_id])
    @comment = event.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to event
    else
      render :action => 'new'
    end
  end
end