class AddDiscordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :discord, :string, null: true
  end
end
