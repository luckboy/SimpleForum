class UsersController < ApplicationController
  load_and_authorize_resource

  private
  def safe_params
    if current_user && current_user.admin?
      params
    else
      tmp_params = params.dup
      tmp_params[:user] = tmp_params[:user].dup
      tmp_params[:user].delete_if { |k, v| ["is_admin", "is_mod"].include? k }
      tmp_params
    end
  end

  public
  # GET /users
  # GET /users.json
  def index
    @users = User.order("login ASC")
    @users = @users.paginate :page => params[:page], :per_page => users_per_page

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = params[:id].nil? ? current_user : User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = params[:id].nil? ? current_user : User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(safe_params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to "/", notice: "Account registered!" }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = params[:id].nil? ? current_user : User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(safe_params[:user])
        format.html { redirect_to "/", notice: "Account updated!" }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
  
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
