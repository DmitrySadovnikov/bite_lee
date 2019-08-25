class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links, id: :uuid do |t|
      t.string :original
      t.string :suffix
      t.timestamps
    end

    add_index :links, :suffix, unique: true
  end
end
