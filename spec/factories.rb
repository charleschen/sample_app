Factory.define :user do |user|
  user.name                   "Charles Chen"
  user.email                  "Charles@example.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content           "Cheese and Rice"
  micropost.association       :user
end