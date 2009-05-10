class RenameColumnPersistanceToken < ActiveRecord::Migration
  def self.up
    rename_column(:users, :persistance_token, :persistence_token)
  end

  def self.down
    rename_column(:users, :persistence_token, :persistance_token)
  end
end
