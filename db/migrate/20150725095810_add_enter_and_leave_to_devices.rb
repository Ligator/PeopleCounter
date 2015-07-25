class AddEnterAndLeaveToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :enter, :integer, default: 0
    add_column :devices, :leave, :integer, default: 0
  end
end
