# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

unless User.find_by_email('phil@purpleriver.dev').present?
  user = User.new(
    first_name: 'Phil',
    last_name: 'Reynolds',
    username: 'Phil',
    email: 'phil@purpleriver.dev',
    admin: true,
    public_profile: true,
    password: 'test1234'
  )
  user.skip_confirmation!
  user.save!
end

unless User.find_by_email('lawrence.archer@gmail.com').present?
  user = User.new(
    first_name: 'Lawrence',
    last_name: 'Archer',
    username: 'Archer',
    email: 'lawrence.archer@gmail.com',
    admin: true,
    password: 'test1234'
  )
  user.skip_confirmation!
  user.save!
end

unless User.find_by_email('garethdandrews@gmail.com').present?
  user = User.new(
    first_name: 'Gareth',
    last_name: 'Andrews',
    username: 'Gary',
    email: 'garethdandrews@gmail.com',
    admin: true,
    public_profile: true,
    password: 'test1234'
  )
  user.skip_confirmation!
  user.save!
end

unless User.find_by_email('db_not_admin@purpleriver.dev').present?
  user = User.new(
    first_name: 'Test',
    last_name: 'Test Not Admin',
    username: 'Not Admin',
    email: 'db_not_admin@purpleriver.dev',
    password: 'test1234'
  )
  user.skip_confirmation!
  user.save!
end

10.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    username: Faker::Coffee.blend_name,
    email: Faker::Internet.email,
    password: 'test1234'
  )
  user.skip_confirmation!
  user.save!
end

# seed Roasters and Coffees from /seeds/*
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }

puts "Add between 1 and 10 random coffees to the user's favourites"
User.all.each do |user|
  puts "User: #{user.id}"
  rand(1..10).times do
    puts "Create Favourite"
    user.favourites.create(
      coffee: Coffee.all.sample
    )
  end
end

puts "Add between 2 and 7 random coffees to the user's shelf"
User.all.each do |user|
  puts "User: #{user.id}"
  rand(2..7).times do
    puts "Create Shelf Items"
    user.shelf_items.create(
      coffee: Coffee.all.sample
    )
  end
end

puts "Create some brews for each of the user's favourites and shelf"
clifton_house = Coffee.find(9)
User.all.each do |user|
  if user.id == 1
    equipment = "V60"
    grinder = "Fellow Ode"
    grind_setting = "3.1"
    method = "Hoffman"
    time = 180
  else
    equipment = ["V60", "Chemex", "French Press", "Aeropress"].sample
    grinder = "Roaster"
    grind_setting = "Filter"
    method = ""
    time = rand(120..600)
  end

  puts "User: #{user.id}"
  user.favourites.each do |favourite|
    puts "Favourite: #{favourite.id}"
    rand(5..20).times do
      puts "Create Brew"
      user.brews.create!(
        coffee: favourite.coffee,
        equipment: equipment,
        method: method,
        coffee_weight: 15,
        water_weight: 250,
        grinder: grinder,
        grinder_setting: grind_setting,
        time: time,
        notes: Faker::Hipster.paragraph,
        rating: rand(4..10),
        created_at: Faker::Time.between_dates(from: 6.months.ago.to_date , to: 1.month.ago.to_date, period: :morning)
      )
    end
  end

  user.shelf_items.each do |shelf|
    puts "Shelf Item: #{shelf.id}"
    rand(2..30).times do
      public = [true, true, true, false].sample
      puts "Create Brew // Public:#{public}"
      user.brews.create!(
        coffee: shelf.coffee,
        equipment: equipment,
        method: method,
        coffee_weight: 15,
        water_weight: 250,
        grinder: grinder,
        grinder_setting: grind_setting,
        time: time,
        notes: Faker::Hipster.paragraph,
        rating: rand(0..10),
        public: public,
        created_at: Faker::Time.between_dates(from: 1.months.ago.to_date , to: Date.today, period: :morning)
      )
    end
  end

  puts "Create Brews for Clifton House Filter"
  rand(2..5).times do
    puts "Create Brew"
    user.brews.create!(
      coffee: clifton_house,
      equipment: "V60",
      method: "Hoffman",
      coffee_weight: 15,
      water_weight: 250,
      grinder: "Roaster",
      grinder_setting: "filter",
      time: 120,
      notes: "Staple, can't go wrong with this",
      rating: 8,
      created_at: Faker::Time.between_dates(from: 6.months.ago.to_date , to: Date.today, period: :morning)
    )
  end
end
