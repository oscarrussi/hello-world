class ChangeDefaultAasm < ActiveRecord::Migration[6.1]
  def change
    change_column_default :articles, :aasm_state, "pending"
  end
end
