class AddIndexToAccomplishmentsTags < ActiveRecord::Migration
  def change
    execute "CREATE INDEX AccomplishmentTagsIndex ON accomplishments USING gin(tags);"
  end
end
