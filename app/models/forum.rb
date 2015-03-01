class Forum < ActiveRecord::Base
  attr_accessible :category_id, :description, :forum_title, :forum_id

  require 'ruby-prof'
  has_many :forum_threads
  has_many :forum_moderators
  has_many :users, :through => :forum_moderators

  # @param [Object] all_threads
  def all_parent_threads(all_threads)
  self.siblings
  end

  # @param [Object] id
  def thread_count(id)
    ForumThread.find_all_by_forum_id(id).count()
  end

  # @param [Object] id
  def last_thread(id)
    ForumThread.find_all_by_forum_id(id).last()
  end

  def moderators(user_id)
    ForumModerator.find_all_by_user_id(user_id)
  end
end
