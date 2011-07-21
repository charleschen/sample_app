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
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.com"
      password = "password"
      User.create!( :name => name,
                    :email => email,
                    :password => password,
                    :password_confirmation => password )
    end
    
    User.all(:limit => 6).each do |user| # only pulls out 6 elements
      50.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
    
  end
  
  
end