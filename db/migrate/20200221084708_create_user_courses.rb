class CreateUserCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :user_courses do |t|
      t.datetime :end_at, null: false, comment: '結束時間'
      t.string :state, null: false, comment: '狀態'
      t.integer :amount, null: false, comment: '金額'
      t.text :note, comment: '備註'
      t.belongs_to :user, foreign_key: true
      t.belongs_to :category, foreign_key: true
      t.belongs_to :course, foreign_key: true

      t.timestamps
    end
  end
end
