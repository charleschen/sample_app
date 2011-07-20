#require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke # runs under the hood
    admin = User.create!( :name => "Example User",
                  :email => "ccchen920@gmail.com",
                  :password => "leines",
                  :password_confirmation => "leines" )
    admin.toggle!(:admin)
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