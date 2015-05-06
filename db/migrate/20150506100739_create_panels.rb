class CreatePanels < ActiveRecord::Migration
  def change
    create_table :panels do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
