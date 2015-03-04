class LatestForumPostController < ApplicationController
  include SessionsHelper

  def index
    if (signed_in?)

      session[:current_forum] = params[:id]
      session[:current_thread] = nil
    end

    #@threads = ForumThread.includes(:forum).order('created_at DESC')#.paginate(page: params[:page], per_page: 5)
    @forum_threads = ForumThread.paginate(page: params[:page], :per_page => 5).includes(:forum).order('created_at DESC')
    #@forum_threads = ForumThread.paginate(page: params[:page], per_page: 5)

    #@forum_threads.paginate(page: params[:page])
    
    if(signed_in?)
    @user = current_user
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @forum_threads }
    end
  end
end
