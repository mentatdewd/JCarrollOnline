class ChangeUrlToTextInRssfeedEntries < ActiveRecord::Migration
  def up
    change_column :rssfeed_entries, :url, :text
  end

  def down
    change_column :rssfeed_entries, :url, :string
  end
end
