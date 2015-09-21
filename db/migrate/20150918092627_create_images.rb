class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :entity_id
      t.string :entity_type

      t.timestamps null: false
    end
  end
end
