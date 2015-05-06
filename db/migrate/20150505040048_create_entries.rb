class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.string :type

      t.timestamps null: false
    end
  end
end
