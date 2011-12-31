class TopicsController < ApplicationController
  load_and_authorize_resource

  # GET /topics
  # GET /topics.json  
  # GET /forums/1/topics
  # GET /forums/1/topics.json
  def index
    unless params[:forum_id].nil?
      @is_search = false
      @forum = Forum.find(params[:forum_id])
      @topics = @forum.topics
    else
      @is_search = true
      @topics = Topic.search(params[:search]).select('DISTINCT topics.*').order(:created_last_post_at).reverse_order
    end
    @topics = @topics.paginate :page => params[:page], :per_page => topics_per_page

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /forums/1/topics/1
  # GET /forums/1/topics/1.json
  def show
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:id])

    respond_to do |format|
      format.html { redirect_to forum_topic_posts_url(@forum, @topic) }
      format.json { render json: @topic }
    end
  end

  # GET /forums/1/topics/new
  # GET /forums/1/topics/new.json
  def new
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.new
    @post = @topic.posts.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /forums/1/topics/1/edit
  def edit
    @forum = Forum.find(params[:forum_id])    
    @topic = Topic.find(params[:id])
    @post = @topic.posts.first
  end

  # POST /forums/1/topics
  # POST /forums/1/topics.json
  def create
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.new(params[:topic].merge(:author => current_user))
    @post = @topic.posts.new(params[:post].merge(:author => current_user))

    respond_to do |format|
      if @topic.save
        format.html { redirect_to [@forum, @topic], notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forums/1/topics/1
  # PUT /forums/1/topics/1.json
  def update
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to [@forum, @topic], notice: 'Topic was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1/topics/1
  # DELETE /forums/1/topics/1.json
  def destroy
    @forum = Forum.find(params[:forum_id])
    @topic = @forum.topics.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to forum_topics_url(@forum) }
      format.json { head :ok }
    end
  end  
  
  # GET /topics/1
  def search
    @search = Topic.search
  end
end
