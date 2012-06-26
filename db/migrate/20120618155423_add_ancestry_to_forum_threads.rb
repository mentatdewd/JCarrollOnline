class AddAncestryToForumThreads < ActiveRecord::Migration
  def up
    add_column :forum_threads, :ancestry, :string
    add_index :forum_threads, :ancestry
  end
  def down
    remove_index :forum_threads, :ancestry
    remove_column :forum_threads, :ancestry
  end
end
