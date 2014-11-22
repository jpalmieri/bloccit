require 'rails_helper' 

describe User do
  include TestFactories

  describe "#favorited(post)" do

    before do
      @post = associated_post
      @user = authenticated_user
    end

    it "returns 'nil' if the user has not favorited the post" do
      @favorite = Favorite.new(post_id: @post.id, user_id: 9999)
      @favorite.save

      expect( @user.favorited(@post) ).to be_nil
    end

    it "returns the appropriate favorite if it exists" do
      @favorite = Favorite.new(post_id: @post.id, user_id: @user.id)
      @favorite.save

      expect( @user.favorited(@post) ).to eq(@favorite)
    end
  end
  
end