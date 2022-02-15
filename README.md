# Daily Brew Coffee

Daily Brew is an upcoming coffee app which will allow you to record your brews, and discover interesting coffees. It is very early in its development!

We're building this in public, because that's fun and we want to build something which people will use! Suggestions welcome.

## Initial Setup

The following is what I did to get the framework of the app up and running. A few things changed a bit later on, such as switching back from Propshaft to Sprockets and dropping css-bundling. It's fun using the latest release of open source frameworks until there's no support for your weird issues!

```zsh
rails new ridethewave -d postgresql -c sass -a propshaft
# add devise, rpsec, faker and factory bot to gemfile
bundle install
rails g devise:install
rails g rspec:install
# delete test directory
git add .
git commit -am "✨ initial commit ☕"
rails g devise User --primary-key-type=uuid
# delete test folder again, we're using rspec
# update devise config and migration
rails db:create
rails db:migrate
git add .
git commit -am "initial Devise setup"

# next steps are going to be scaffolding for some of the other models
# follow along in the commits if you're still wanting to!

rails g scaffold Roaster user:belongs_to name:string description:text location:string 'lat:decimal{10,6}' 'lng:decimal{10,6}' website:string twitter:string instagram:string facebook:string -t rspec --primary-key-type=string

rails g scaffold Coffee roaster:belongs_to name:string country:string region:string town:string 'lat:decimal{10,6}' 'lng:decimal{10,6}' process:string altitude:integer variety:string tasting_notes:string producer:string description:text url:string -t rspec

rails g scaffold Brew user:belongs_to coffee:belongs_to equipment:string method:string coffee_weight:integer water_weight:integer grinder:string grinder_setting:string time:integer notes:text rating:integer -t rspec --no-jbuilder

rails g model Review user:belongs_to coffee:belongs_to rating:integer content:text public:boolean -t rspec --no-jbuilder; rails g controller Reviews -t rspec

rails g model Shelf user:belongs_to coffee:belongs_to -t rspec --no-jbuilder; rails g controller shelf_items -t rspec

rails g model Favourite user:belongs_to coffee:belongs_to -t rspec --no-jbuilder; rails g controller Favourites -t rspec

# from here on, everything is a bit more manual!


## Late addition
# At some point quite early in this process we should have run:
rails importmap:install
```