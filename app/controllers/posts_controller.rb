class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_post, only: %i[show edit update destroy]

  def index
    @pagy, @posts = pagy(Post.with_attached_images.all.order(updated_at: :desc))
  end

  def show
    @comments = @post.comments.sorted
    @new_comment = current_user&.comments&.build
  end

  def new
    @post ||= Post.new
  end

  def edit; end

  def create
    @post ||= current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Your post successfully created'
    else
      flash.now[:alert] = 'Post was not created'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: 'Your post successfully updated'
    else
      flash.now[:alert] = 'Post was not updated'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, notice: 'Post was successfully deleted'
    else
      redirect_to post_path(@post), notice: 'Post was not deleted'
    end
  end

  private

  def load_post
    @post ||= Post.with_attached_images.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :body, images: [])
  end
end
