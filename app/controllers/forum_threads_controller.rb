class ForumThreadsController < ApplicationController
  before_filter :add_forum_breadcrumb

  impressionist :actions => [:show, :index]
  #add_breadcrumb 'Edit a thread', '', :only => [:edit, :update]

  # GET /forum_threads
  # GET /forum_threads.json
  # @return [Object]
  def index
    @forum_thread = ForumThread.find(params[:id])
    @forum_threads = @forum_thread.subtree

    add_breadcrumb @forum_thread.forum_thread_title, forum_threads_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forum_threads }
    end
  end

  # GET /forum_threads/1
  # GET /forum_threads/1.json
  def show
    @forum_thread = ForumThread.find(params[:id])
    impressionist(@forum_thread) #message is optional

    @user = current_user
    session[:current_thread] = params[:id]
    add_breadcrumb "Thread", :thread_path

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @forum_thread }
    end
  end

  # GET /forum_threads/new
  # GET /forum_threads/new.json
  def new
    @forum_thread = ForumThread.new(:forum_id => params[:forum_id], :parent_id => params[:parent_id])
    @forum_thread.author_id=current_user.id
    @forum_thread.forum_id=params[:forum_id]
    @forum_thread.parent_id=params[:parent_id]
    @current_forum = Forum.find(@forum_thread.forum_id)
    add_breadcrumb @current_forum.forum_title, forum_path(:forum_id)
    if(params[:parent_id].nil?)
      add_breadcrumb "New thread", new_forum_thread_path
    else
      add_breadcrumb "Repy to thread", new_forum_thread_path
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @forum_thread }
    end
  end

  # GET /forum_threads/1/edit
  def edit
    @forum_thread = ForumThread.find(params[:id])
  end

  # POST /forum_threads
  # POST /forum_threads.json
  def create
    @forum_thread = ForumThread.new(params[:forum_thread])
    Forum.find(@forum_thread.forum_id).touch()
    respond_to do |format|
      if @forum_thread.save
        format.html { redirect_to forum_threads_path(:id => @forum_thread.root.id, :parent_id => @forum_thread.root.id), notice: 'Forum thread was successfully created.' }
        format.json { render json: forum_path, status: :created, location: @forum_thread }
      else
        format.html { render action: "new" }
        format.json { render json: @forum_threads.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forum_threads/1
  # PUT /forum_threads/1.json
  def update
    @forum_thread = ForumThread.find(params[:id])
    @forum_threads = @forum_thread.subtree

    respond_to do |format|
      if @forum_thread.update_attributes(params[:forum_thread])
        format.html { redirect_to forum_threads_path(:id => @forum_thread.root.id, :parent_id => @forum_thread.root.id), notice: 'Forum thread was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @forum_thread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_threads/1
  # DELETE /forum_threads/1.json
  def destroy
    @forum_thread = ForumThread.find(params[:id])
    @forum_id = @forum_thread.forum_id
    @forum_parent_id = @forum_thread.root_id
    @forum_thread.destroy

    if (@forum_thread.id == @forum_parent_id)
      respond_to do |format|
        flash[:success] = "Forum thread deleted"
        format.html { redirect_to forum_path(:id => @forum_id) }
        format.json { render json: @forum, status: :deleted, location: @forum_thread }
      end
    else
      respond_to do |format|
        flash[:success] = "Reply deleted"
        format.html { redirect_to forum_threads_url(:id => @forum_parent_id, :forum_id => @forum_id) }
        format.json { head :no_content }
      end
    end
  end

  private
  def add_breadcrumbs
  end

  #@return [Object]
  def add_forum_breadcrumb
    add_breadcrumb 'Home', :root_path
    add_breadcrumb 'Forums', :forums_path
    if(!params[:id].nil?)
      forum_thread = ForumThread.find(params[:id])
      forum = Forum.find(forum_thread.forum_id)
      add_breadcrumb forum.forum_title, forum_path(forum.id)
    end
   end
end
