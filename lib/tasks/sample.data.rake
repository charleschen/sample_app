#require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke # runs under the hood
    User.create!( :name => "Example User",
                  :email => "example@example.com",
                  :password => "foobar",
                  :password_confirmation => "foobar" )
    99.times do |n|
      name = "Charles#{n+1}" #Faker::Name.name
      email = "#{name}@example.com"
      password = "password"
      User.create!( :name => name,
                    :email => email,
                    :password => password,
                    :password_confirmation => password )
    end
  end
end