# typed: true
class CreateArchivedPages < ActiveRecord::Migration[5.2]
  def change
    create_table :archived_pages, id: :serial do |t|
      t.string :title
      t.text :body
      t.integer :parent_id
      t.datetime :original_created_at
      t.datetime :original_updated_at
      t.string :tags, array: true

      t.timestamps
    end
  end
end
