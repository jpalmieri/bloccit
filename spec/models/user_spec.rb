require 'rails_helper' 

describe User do

  describe "#favorited(post)" do

    before do
      @post = create(:post)
      @user = create(:user)
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
  
  describe ".top_rated" do

    before do
      @user1 = create(:user_with_post_and_one_comment)
      @user2 = create(:user_with_post_and_two_comments)
    end

    it "returns users ordered by comments + posts" do
      expect( User.top_rated ).to eq([@user2, @user1])
    end

    it "stores a 'posts_count' on a user" do
      users = User.top_rated
      expect( users.first.posts_count ).to eq(1)
    end

    it "stores a 'comments_count' on a user" do
      users = User.top_rated
      expect( users.first.comments_count ).to eq(2)
    end
  end

end