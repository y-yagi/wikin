# typed: true
class AddTagsToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :tags, :string, array: true
  end
end
