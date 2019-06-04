class CreatePeople < ActiveRecord::Migration[4.2]
  def self.up
    create_table :people do |t|
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
