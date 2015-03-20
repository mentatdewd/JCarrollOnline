class AddThreadPostNumber < ActiveRecord::Migration
  def up
    add_column :forum_threads, :thread_post_number, :integer
  end

  def down
    remove_column :forum_threads, :thread_post_number
  end
end
