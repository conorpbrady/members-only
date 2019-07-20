class PostsController < ApplicationController

  before_action :logged_in_user, only: [:new, :create]


  def new
  end

  def create
    uid = current_user.user_id
    content = params[:post][:content]
    @post = Post.new(user_id: uid, content: content)
    if @post.save
      flash[:success]
      redirect_to root_url
    end
  end

  def index
    @posts = Post.all
  end

end
