class PostsController < ApplicationController
  load_and_authorize_resource
  
  # GET /forums/1/topics/1/posts
  # GET /forums/1/topics/1/posts.json
  def index
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @posts = @topic.posts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /forums/1/topics/1/posts/1
  # GET /forums/1/topics/1/posts/1.json
  def show
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /forums/1/topics/1/posts/new
  # GET /forums/1/topics/1/posts/new.json
  def new
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = @topic.posts.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /forums/1/topics/1/posts/1/edit
  def edit
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
  end

  # POST /forums/1/topics/1/posts
  # POST /forums/1/topics/1/posts.json
  def create
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = @topic.posts.new(params[:post].merge(:author => current_user))

    respond_to do |format|
      if @post.save
        format.html { redirect_to [@forum, @topic, @post], notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forums/1/topics/1/posts/1
  # PUT /forums/1/topics/1/posts/1.json
  def update
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to [@forum, @topic, @post], notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1/topics/1/posts/1
  # DELETE /forums/1/topics/1/posts/1.json
  def destroy
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to forum_topic_posts_url(@forum, @topic) }
      format.json { head :ok }
    end
  end
end
