class AddContextIdToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :context_id, :integer
  end
end
