class AddTagsToOldPage < ActiveRecord::Migration[5.0]
  def change
    add_column :old_pages, :tags, :string, array: true
  end
end
