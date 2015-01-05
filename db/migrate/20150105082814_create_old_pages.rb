class CreateOldPages < ActiveRecord::Migration
  def change
    create_table :old_pages do |t|
      t.text :body
      t.references :page, index: true

      t.timestamps null: false
    end
  end
end
