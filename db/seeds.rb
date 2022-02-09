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
    terms: true,
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
    terms: true,
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
    terms: true,
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
    email: 'rtw_not_admin@purpleriver.dev',
    terms: true,
    password: 'test1234'
  )
  user.skip_confirmation!
  user.save!
end

# seed Roasters and Coffees from /seeds/*
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }
