class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.integer :counter, default: 0
      t.string :name

      t.timestamps
    end
  end
end
