class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title
      t.string :url
      t.integer :periodicity, :default => 5
      t.string :secret_key
      t.text :data
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
