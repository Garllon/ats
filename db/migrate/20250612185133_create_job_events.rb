class CreateJobEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :job_events do |t|
      t.string :type
      t.references :job, null: false, foreign_key: true
      t.jsonb :metadata

      t.timestamps
    end
  end
end
