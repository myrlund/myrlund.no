class PostsController < ApplicationController
  respond_to :html, :json
  
  load_and_authorize_resource except: [:draft]
  
  # GET /posts
  # GET /posts.json
  def index
    unless can?(:manage, Post)
      @posts = @posts.published
    end
    
    respond_with @posts
  end
  
  def drafts
    @posts = Post.drafts
    
    authorize! :manage, @posts
    
    render 'index'
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    respond_with @post
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    respond_with @post
  end

  # GET /posts/1/edit
  def edit
    respond_with @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post.author = current_user

    if @post.save
      flash[:notice] = 'Post was successfully created.'
    end
    
    respond_with @post
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    if @post.update_attributes(params[:post])
      flash[:notice] = 'Post was successfully updated.'
    end
    
    respond_with @post
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy

    respond_with @post
  end
end
