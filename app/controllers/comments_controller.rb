class CommentsController < ApplicationController
  respond_to :html, :js

  def create
    @post = Post.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build( comment_params )
    @comment.post = @post

    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was saved."
    elsif @comment.errors.any?
      flash[:error] = "Error#{'s' if @comment.errors.count > 1} saving comment: 
      #{@comment.errors.full_messages.join(', ')}"
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end

    respond_with(@comment) do |format|
      format.html { redirect_to [@post.topic, @post] }
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

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
