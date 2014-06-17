class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.integer :parent_id
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :pages, [:title, :deleted_at]
    add_index :pages, [:parent_id, :deleted_at]
    add_index :pages, :deleted_at
  end
end
