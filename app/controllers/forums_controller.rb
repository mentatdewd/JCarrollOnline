class ForumsController < ApplicationController
  include SessionsHelper

  add_breadcrumb 'Home', :root_path
  add_breadcrumb 'Forums', :forums_path
  add_breadcrumb 'Edit a thread', '', :only => [:edit, :update]

  # GET /forums
  # GET /forums.json
  def index
    @forums = Forum.paginate(page: params[:page])
    @user = current_user

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forums }
    end
  end

  # GET /forums/1
  # GET /forums/1.json
  def show
    @forum = Forum.find(params[:id])
    session[:current_forum] = params[:id]
    session[:current_thread] = nil

    @forum_threads = ForumThread.where("forum_id = ?", params[:id])
    @forum_threads = @forum_threads.sort_by {|forum_thread| - forum_thread.updated_at.to_i}
    @user = current_user
    @user.moderator = ForumModerator.where(:moderator_id => @user.id, :forum_id => @forum.id).count
    add_breadcrumb "Forum", :forum_path

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @forum }
    end
  end

  # GET /forums/new
  # GET /forums/new.json
  def new
    @forum = Forum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @forum }
    end
  end

  # GET /forums/1/edit
  def edit
    @forum = Forum.find(params[:id])
  end

  # POST /forums
  # POST /forums.json
  def create
    @forum = Forum.new(params[:forum])

    respond_to do |format|
      if @forum.save
        format.html { redirect_to forums_path, notice: 'Forum was successfully created.' }
        format.json { render json: forums_path, status: :created, location: @forum }
      else
        format.html { render action: "new" }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forums/1
  # PUT /forums/1.json
  def update
    @forum = Forum.find(params[:id])

    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        format.html { redirect_to @forum, notice: 'Forum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.json
  def destroy
    @forum = Forum.find(params[:id])
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to forums_url }
      format.json { head :no_content }
    end
  end
end
