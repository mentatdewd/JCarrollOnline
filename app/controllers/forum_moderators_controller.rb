class ForumModeratorsController < ApplicationController
  before_filter :signed_in_user, :admin_user

  def index
    @forum = Forum.find(params[:forum])
    @moderators = @forum.forum_moderators
    #.paginate(page: params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forum }
    end
  end

  def new
    @forum = Forum.find(params[:forum])
    @forum_moderators = ForumModerator.where(:forum_id => @forum.id)
    @users = User.all(:select => "*", :conditions => ["id not in (select moderator_id from forum_moderators)"])
    @forum_moderator = ForumModerator.new
    @forum_moderator.forum_id=@forum.id

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @forum }
    end
  end

  def create
    @forum_moderator = ForumModerator.new :moderator_id => params[:moderator_id], :forum_id => params[:forum_moderator][:forum_id]

    respond_to do |format|
      if @forum_moderator.save
        format.html { redirect_to forum_moderators_path(:forum => params[:forum_moderator][:forum_id]), notice: 'Forum was successfully created.' }
        format.json { render json: forum_moderators_path(:forum => params[:forum_moderator][:forum_id]), status: :created, location: @forum }
      else
        format.html { render action: "new" }
        format.json { render json: @moderator.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @forum_moderator = ForumModerator.find(params[:id])
    @forum_id = @forum_moderator.forum_id
    @forum_moderator.destroy

    respond_to do |format|
      format.html { redirect_to forum_moderators_path(:forum => "5") }
      format.json { head :no_content }
    end
  end

  private
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
  end