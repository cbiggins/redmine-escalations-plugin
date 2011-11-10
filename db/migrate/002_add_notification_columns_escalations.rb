class AddNotificationColumnsEscalations < ActiveRecord::Migration
  def self.up
      add_column :escalations, :date_notified, :datetime
      add_column :escalations, :status, :integer
  end
  
  def self.down
      remove_column :escalations, :date_notified
      remove_column :escalations, :status
  end
end