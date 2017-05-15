# coding: utf-8
namespace :data do
  desc "Rake DataBase"
  task dev_load: :environment do
    p "Migrate data"
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke

    p "Create 30 users"
    (1..30).each do
      User.create! name: Faker::Name.name, avatar: Faker::Avatar.image, age: 18,
        address: Faker::Address.street_address
    end

    p "Create 30 Videos for each user"
    status = Settings.videos.status.map(&:last)
    mime_types = Settings.videos.mime_types.map(&:last)
    google_files = %w(
      0B8z8I4jOIwFlLXVhZl9idFJDNlU
      0B8z8I4jOIwFlblpBSDZlR2kxRDA
      0B8z8I4jOIwFlX0tTY3dsUXBOalU
      0B8z8I4jOIwFlblpBSDZlR2kxRDA
      0B8z8I4jOIwFlMURkTWpLYk1YVzg
      0B8z8I4jOIwFlVEw2cVZwWUlGYzA
    )
    User.all.each do |user|
      (1..30).each do
        user.videos.create! title: Faker::Name.title, status: status.sample,
         mime_type: mime_types.sample, google_file: google_files.sample
      end
    end
    p "Finish create database"
  end
end
