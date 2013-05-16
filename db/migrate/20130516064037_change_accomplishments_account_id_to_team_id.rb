class ChangeAccomplishmentsAccountIdToTeamId < ActiveRecord::Migration
  def change
    change_table :accomplishments do |t|
      t.rename :account_id, :team_id
    end
  end
end
