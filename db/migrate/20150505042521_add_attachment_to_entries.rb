class AddAttachmentToEntries < ActiveRecord::Migration
  def self.up
    change_table :entries do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :entries, :file
  end
end
