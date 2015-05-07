class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.references :panel, index: true, foreign_key: true
      t.references :entry, index: true, foreign_key: true
      t.integer :duration
      t.time :starts_at
      t.time :ends_at
      t.integer :position

      t.timestamps null: false
    end
  end
end
