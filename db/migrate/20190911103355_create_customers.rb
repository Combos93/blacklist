class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.string :description, null: false
      t.boolean :blacklisted, null: false, default: false

      t.timestamps
    end
  end
end
