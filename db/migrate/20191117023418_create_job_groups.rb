class CreateJobGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :job_groups do |t|
      t.string :name
      t.float :wage

      t.timestamps
    end
  end
end
