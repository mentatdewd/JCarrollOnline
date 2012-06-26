class AddImpressionsCountToForumThreads < ActiveRecord::Migration
  def up
    add_column :forum_threads, :impressions_count, :integer
  end
  def down
    remove_column :forum_threads, :impressions_count
  end
end
