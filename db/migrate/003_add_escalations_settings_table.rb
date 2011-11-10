class AddEscalationsSettingsTable < ActiveRecord::Migration
  def self.up
    create_table :escalations_settings do |t|
      t.column :id, :integer
      t.column :setting, :string
      t.column :value, :text
    end
  end

  def self.down
    drop_table :escalations_settings
  end
end