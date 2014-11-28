class CommentsController < ApplicationController
  respond_to :html, :js

  def create
    @post = Post.find(params[:post_id])
    @topic = @post.topic
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
    @post = Post.find(params[:post_id])
    @topic = @post.topic
    @comment = Comment.find(params[:id])
    body = @comment.body

    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was deleted successfully."
    else
      flash[:error] = "There was an error deleting the post. Please try again."
    end

    respond_with(@comment) do |format|
      format.html { redirect_to [@post.topic, @post] }
    end
  end

end
