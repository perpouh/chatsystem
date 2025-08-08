class AddColumnsToIssues < ActiveRecord::Migration[7.2]
  def change
    add_column :issues, :issue_status, :integer, default: 0
    add_column :issues, :archived_at, :datetime, null: true, default: nil
  end
end
