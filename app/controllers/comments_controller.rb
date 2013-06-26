class CommentsController < ApplicationController

  def create
    commentable = Event.find(params[:event_id])
    commentable.comments.create(:comment => params[:comment], :user_id => current_user.id)
    redirect_to event_path(commentable.url)
  end
end
