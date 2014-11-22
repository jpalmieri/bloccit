class FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    authorize favorite

    if favorite.save
      flash[:notice] = "Favorite saved."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was a problem saving your favorite. Please try again."
      redirect_to [@post.topic, @post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.where(post_id: @post.id).first
    authorize favorite

    if favorite.destroy
      flash[:notice] = "Post unfavorited."
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "There was a problem removing your favorite. Please try again."
      redirect_to [@post.topic, @post]
    end
  end

end
