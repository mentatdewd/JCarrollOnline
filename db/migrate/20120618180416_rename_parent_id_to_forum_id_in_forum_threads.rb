class RenameParentIdToForumIdInForumThreads < ActiveRecord::Migration
  def up
    rename_column :forum_threads, :parent_id, :forum_id
  end

  def down
    rename_column :forum_threads, :forum_id, :parent_id
  end
end
