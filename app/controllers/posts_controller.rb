class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def index
    @posts = Post.all
  end

  def vote
    @vote = Vote.create(voteable: @post, user: current_user, vote: params[:vote])
    respond_to do |format|
      if @vote.valid?
        format.html {redirect_to :back, notice: "Your vote was counted!"}
        format.js
      else
        format.html {redirect_to :back, notice: "Your vote wasn't counted!"}
        format.js {
          render 'vote_failure'
        }
      end
    end
  end
  
  def show
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.json {render json: @post, except: [:id, :slug]} 
    end
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Your post was updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: []) 
  end
end
