class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name, comment: '主題', null: false
      t.text :desc, comment: '描述', default: ''
      t.string :url, comment: 'URL'
      t.string :state, comment: '狀態', null: false
      t.integer :price, comment: '價錢', null: false
      t.string :currency, comment: '幣別', null: false
      t.datetime :available_day, comment: '使用期限', null: false
      t.belongs_to :user, foreign_key: true
      t.belongs_to :category, foreign_key: true

      t.timestamps
    end
  end
end
