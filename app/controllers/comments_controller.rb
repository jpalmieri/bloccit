class CommentsController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(params.require(:comment).permit(:body))
    @comment.post = @post
    authorize @comment
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@topic, @post]
    elsif @comment.errors.any?
      flash[:error] = "Error#{'s' if @comment.errors.count > 1} saving comment: 
      #{@comment.errors.full_messages.join(', ')}"
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      redirect_to [@topic, @post]
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    body = @comment.body

    authorize @comment
    if @comment.destroy
      flash[:notice] = "\"#{body}\" was deleted successfully."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error deleting the post. Please try again."
      redirect_to [@topic, @post]
    end
  end

end
