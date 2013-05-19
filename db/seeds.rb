# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# User.delete_all
# Project.delete_all
# Todo.delete_all

User.delete_all
Team.delete_all
Accomplishment.delete_all
Comment.delete_all
Like.delete_all

user = User.create! name: "Test User",
                    email: "test_dun@crc.io",
                    password: 'password',
                    password_confirmation: 'password'


["Personal", "Work"].each do |team_name|
    team = user.teams.create! name: team_name
    [
        "Pluck chicken",
        "Make coat from chicken",
        "Shave yak",
        "Melt wizard staff"
    ].each {|accomplishment| user.accomplishments.create! title: accomplishment, team: team }
end
