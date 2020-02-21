class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, comment: '類別名稱'

      t.timestamps
    end
  end
end
