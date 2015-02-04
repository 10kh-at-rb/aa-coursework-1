# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.transaction do

  TagTopic.create(:name => "news")
  TagTopic.create(:name => "music")
  TagTopic.create(:name => "sports")
  TagTopic.create(:name => "entertainment")
  TagTopic.create(:name => "politics")
  TagTopic.create(:name => "science")
  TagTopic.create(:name => "tech")
  TagTopic.create(:name => "fun")

end
