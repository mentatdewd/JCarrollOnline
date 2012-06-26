class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.integer :category_id
      t.string :forum_title
      t.string :description

      t.timestamps
    end
  end
end
