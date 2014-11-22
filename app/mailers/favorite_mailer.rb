class FavoriteMailer < ActionMailer::Base
  default from: "jpalmieri@lumoslabs.com"

  def new_comment(user, post, comment)

    # New Headers
    headers["Message-ID"] = "<comments/#{comment.id}@bloccit-jpalmieri.herokuapp.com"
    headers["In-Reply-To"] = "<post/#{post.id}@bloccit-jpalmieri.herokuapp.com"
    headers["References"] = "<post/#{post.id}@bloccit-jpalmieri.herokuapp.com"

    @user = user
    @post = post
    @comment = comment

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end
