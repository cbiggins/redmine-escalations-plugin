class CreateEscalations < ActiveRecord::Migration
  def self.up
    create_table :escalations do |t|
      t.column :project_id, :integer
      t.column :issue_id, :integer
      t.column :date_escalated, :datetime
      t.column :notification_sent, :integer
    end
  end

  def self.down
    drop_table :escalations
  end
end
