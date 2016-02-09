class AddContextIdToPanels < ActiveRecord::Migration
  def change
    add_column :panels, :context_id, :integer
  end
end
