class CreateForumModerators < ActiveRecord::Migration
  def change
    create_table :forum_moderators do |t|
      t.integer :user_id
      t.integer :forum_id

      t.timestamps
    end
  end
end
