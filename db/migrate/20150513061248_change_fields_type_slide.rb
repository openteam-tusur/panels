class ChangeFieldsTypeSlide < ActiveRecord::Migration

  def up
    remove_column :slides, :starts_at
    add_column :slides, :starts_at, :datetime
    remove_column :slides, :ends_at
    add_column :slides, :ends_at, :datetime
  end

  def down
    remove_column :slides, :starts_at
    add_column :slides, :starts_at, :time
    remove_column :slides, :ends_at
    add_column :slides, :ends_at, :time
  end

end
