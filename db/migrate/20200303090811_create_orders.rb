class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :user_course, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
