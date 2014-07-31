# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = [User.create!({username: "mschlenk",password: "drizzy"}),
         User.create!({username: "SamuelTheThird",password: "fishfry"}),
         User.create!({username: "mrcatlover", password: "sennacy"})]

names = ["dsdf", "donkey", "smelly", "scratchenstein", "sir catticus"]
birthdates = (10.years.ago.to_date..Date.today).to_a
sexes = ["M", "F"]
descriptions = ["Awesome cat", "Terrible scratcher", "Hates my fiancee",
                    "Dates his yarnball", "Vegetarian"]


def calculate_age(birthdate)
  Integer(Date.today - birthdate)/365
end

cats = []
cat_user_ids = {}
5.times do |n|
  birthdate = birthdates.delete(birthdates.sample)
  cat = Cat.create!(
    name: names.sample, birthdate: birthdate,
    age: calculate_age(birthdate), sex: sexes.sample, color: Cat::COLORS.sample,
    description: descriptions.sample, user_id: users.sample.id
  )
  cats << cat
  cat_user_ids[cat.id] = cat.user_id
end


rentals = CatRentalRequest.create!([
{cat_id: cats[0].id, start_date: "2014-07-03", end_date: "2014-08-01", user_id: cat_user_ids[cats[0].id]},
{cat_id: cats[0].id, start_date: "2014-07-23", end_date: "2014-07-27", user_id: cat_user_ids[cats[0].id]},
{cat_id: cats[1].id, start_date: "2014-07-09", end_date: "2014-07-24", user_id: cat_user_ids[cats[1].id]},
{cat_id: cats[1].id, start_date: "2014-07-20", end_date: "2014-07-25", user_id: cat_user_ids[cats[1].id]},
{cat_id: cats[2].id, start_date: "2014-07-30", end_date: "2014-08-06", user_id: cat_user_ids[cats[2].id]},
{cat_id: cats[2].id, start_date: "2014-07-31", end_date: "2014-08-02", user_id: cat_user_ids[cats[2].id]},
{cat_id: cats[0].id, start_date: "2014-08-01", end_date: "2014-08-02", user_id: cat_user_ids[cats[0].id]}])