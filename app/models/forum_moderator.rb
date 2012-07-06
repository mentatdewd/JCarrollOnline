class ForumModerator < ActiveRecord::Base
  attr_accessible :forum_id, :moderator_id
  belongs_to :moderated_forums, class_name: "Forum"
  belongs_to :forum_moderators, class_name: "User"
end
