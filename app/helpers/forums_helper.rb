module ForumsHelper
  def is_moderator(user_id, forum_id)
    forum_moderator = ForumModerator.where(:moderator_id => user_id, :forum_id => forum_id)
    if forum_moderator.nil?
      false
    else
      true
    end
  end
end
