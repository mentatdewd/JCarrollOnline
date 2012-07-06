module ForumModeratorsHelper
  def get_moderator(user)
    User.find(user)
  end

 end