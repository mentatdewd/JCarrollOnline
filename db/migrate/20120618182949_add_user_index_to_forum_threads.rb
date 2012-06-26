class AddUserIndexToForumThreads < ActiveRecord::Migration
  def up
    add_index :forum_threads, :author_id
  end

  def down
    remove_index :forum_threads, :author_id
  end
end
