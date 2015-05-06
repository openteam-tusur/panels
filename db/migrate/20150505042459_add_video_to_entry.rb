class AddVideoToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :video, :string
  end
end
