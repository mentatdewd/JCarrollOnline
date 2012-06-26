class ForumThread < ActiveRecord::Base
  attr_accessible :author_id, :forum_thread_content, :forum_thread_title, :forum_id, :parent_id
  is_impressionable :counter_cache => true
  has_ancestry

  belongs_to :forum
  belongs_to :user, :foreign_key => "author_id"


  # @return [Object]
  def any_replies?
    self.has_children?
  end

  # @param [Object] id
  def thread_count(forum_thread)
    forum_thread.descendants.count
  end

  def get_recs
    "0"
  end


  # @param [Object] forum_thread
  def get_views(forum_thread)
    forum_thread.impressionist_count
  end

  # @param [Object] forum_thread
  def get_last_reply(forum_thread)
    self.children.all(:order => :created_at).last
  end
end
