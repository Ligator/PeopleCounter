class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.belongs_to :venue, index: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
