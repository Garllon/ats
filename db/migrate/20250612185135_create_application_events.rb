class CreateApplicationEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :application_events do |t|
      t.string :type
      t.references :application, null: false, foreign_key: true
      t.jsonb :metadata

      t.timestamps
    end
  end
end
