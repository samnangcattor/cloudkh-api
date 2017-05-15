# coding: utf-8
namespace :data do
  desc "Rake DataBase"
  task dev_load: :environment do
    p "Migrate data"
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke

    p "Create 100 users"
    (1..100).each do
      User.create! name: Faker::Name.name, avatar: Faker::Avatar.image, age: 18,
        address: Faker::Address.street_address
    end

    p "Finish create database"
  end
end
