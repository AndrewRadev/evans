class AddBasicTestCaseToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :basic_test_case, :text, null: true
  end
end
