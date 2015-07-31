class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :venue, index: true
      t.integer :counter

      t.timestamps
    end
  end
end
