class RenameUserIdInForumModerators < ActiveRecord::Migration
  def up
    rename_column :forum_moderators, :user_id, :moderator_id
  end

  def down
    rename_column :forum_moderators, :moderator_id, :user_id
  end
end
