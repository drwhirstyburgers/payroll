class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.integer :employee_id
      t.float :sum_of_hours, default: 0
      t.float :sum_of_wages, default: 0

      t.timestamps
    end
  end
end
