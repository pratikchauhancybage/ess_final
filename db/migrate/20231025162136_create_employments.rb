class CreateEmployments < ActiveRecord::Migration[7.0]
  def change
    create_table :employments do |t|
      t.date :start_date
      t.date :end_date
      t.integer :employee_id
      t.timestamps
    end
  end
end
