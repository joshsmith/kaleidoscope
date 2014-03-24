ActiveRecord::Schema.define do
  self.verbose = false

  create_table :photos, :force => true do |t|
    t.timestamps
  end

  create_table :photo_colors do |t|
    t.integer :photo_id
    t.string :original_color
    t.string :reference_color
    t.float :frequency
    t.integer :distance

    t.timestamps
  end

  add_index :photo_colors, :photo_id
  add_index :photo_colors, :original_color
  add_index :photo_colors, :reference_color
  add_index :photo_colors, :frequency
  add_index :photo_colors, :distance
end