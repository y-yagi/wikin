class AddTitleAndParentIdToOldPages < ActiveRecord::Migration[4.2]
  def change
    add_column :old_pages, :parent_id, :integer
    add_column :old_pages, :title, :string
  end
end
