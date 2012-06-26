class CreateForumThreads < ActiveRecord::Migration
  def change
    create_table :forum_threads do |t|
      t.string :forum_thread_title
      t.text :forum_thread_content
      t.integer :author_id
      t.boolean :locked
      t.integer :parent_id

      t.timestamps
    end
  end
end
