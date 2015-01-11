class PostsController < ApplicationController
  def index
    if logged_in? && current_user.group[/admin|newsman/]
      @posts = Post.order('published_at desc').page(params[:page]).per(10)
    else
      @posts = Post.where.not(published_at: nil).order('published_at desc').page(params[:page]).per(10)
    end
  end

  def show
    @post = Post.find(params[:id])
  end
end
