class CreateSettings < ActiveRecord::Migration[5.0]
  def change
    create_table :settings do |t|
      t.boolean :enable_one_time_password, default: false, null: false
      t.string :one_time_password_secret

      t.timestamps
    end
  end
end
