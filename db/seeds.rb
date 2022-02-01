# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

unless User.find_by_email('philr@purpleriver.dev').present?
  user = User.new(
    first_name: 'Phil',
    last_name: 'Reynolds',
    username: 'Phil',
    email: 'philr@purpleriver.dev',
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