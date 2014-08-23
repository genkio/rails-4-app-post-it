class CommentsController < ApplicationController
  before_action :require_user
  
  def new
  end

  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "Your comment was posted"
      redirect_to post_path(@post)
    else
      @post.comments.reload
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, user: current_user, vote: params[:vote])
    respond_to do |format|
      if @vote.valid?
        format.html {redirect_to :back, notice: "Your vote was counted!"}
        format.js {
          #question #1 have no idea where to put the vote.js.erb file, that's why I'm using render js here...
          #question #2 how come the code below does not work?
          render js: "$('#comment_<%= comment.id %>_votes').html('<%= comment.total_votes %>');"
        }
      else
        format.html {redirect_to :back, notice: "Your vote wasn't counted!"}
        format.js {
          render js: "alert('Sorry, you can only vote once...');"
        }
      end
    end
  end

end
