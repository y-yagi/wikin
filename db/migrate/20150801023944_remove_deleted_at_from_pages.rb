class RemoveDeletedAtFromPages < ActiveRecord::Migration[4.2]
  def change
    remove_column :pages, :deleted_at, :datetime
  end
end
