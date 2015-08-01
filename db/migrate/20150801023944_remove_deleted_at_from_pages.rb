class RemoveDeletedAtFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :deleted_at, :datetime
  end
end
