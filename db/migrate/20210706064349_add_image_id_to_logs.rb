class AddImageIdToLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :logs, :image_id, :string
  end
end
