class AddAdminToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :admin, :integer
  end
end
