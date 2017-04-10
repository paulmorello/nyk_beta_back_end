# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Job.destroy_all
# GenreTag.destroy_all
# PresstypeTag.destroy_all
# Country.destroy_all
# Genre.destroy_all
# Presstype.destroy_all
# Outlet.destroy_all
# Writer.destroy_all


require 'csv'

# User.create(email: "a.w.garver@gmail.com", password: "1qaz@WSX", password_confirmation: "1qaz@WSX", confirmed_at: Time.now, admin: true)
# User.create(email: "admin01@test.com", password: "admin01", password_confirmation: "admin01", confirmed_at: Time.now, admin: true)
# User.create(email: "admin02@test.com", password: "admin02", password_confirmation: "admin02", confirmed_at: Time.now, admin: true)
# User.create(email: "admin03@test.com", password: "admin03", password_confirmation: "admin03", confirmed_at: Time.now, admin: true)
# User.create(email: "admin04@test.com", password: "admin04", password_confirmation: "admin04", confirmed_at: Time.now, admin: true)
# User.create(email: "admin05@test.com", password: "admin05", password_confirmation: "admin05", confirmed_at: Time.now, admin: true)
# User.create(email: "user01@test.com", password: "user01", password_confirmation: "user01", confirmed_at: Time.now)
# User.create(email: "user02@test.com", password: "user02", password_confirmation: "user02", confirmed_at: Time.now)
# User.create(email: "user03@test.com", password: "user03", password_confirmation: "user03", confirmed_at: Time.now)
# User.create(email: "user04@test.com", password: "user04", password_confirmation: "user04", confirmed_at: Time.now)
# User.create(email: "user05@test.com", password: "user05", password_confirmation: "user05", confirmed_at: Time.now)

CSV.foreach(Rails.root.to_s+'/db/imports/country.csv',
            headers: true,
            skip_blanks: true,
            skip_lines: /^(?:,\s*)+$/) do |row|
            row = row.to_hash
            puts row["name"]
            unless Country.where(name: row["name"]).exists?
              Country.create(row)
            else
              puts "country DOES exist so skip"
            end
end

CSV.foreach(Rails.root.to_s+'/db/imports/genres.csv',
            headers: true,
            skip_blanks: true,
            skip_lines: /^(?:,\s*)+$/) do |row|
  Genre.create(row.to_hash)
end

CSV.foreach(Rails.root.to_s+'/db/imports/press_types.csv',
            headers: true,
            skip_blanks: true,
            skip_lines: /^(?:,\s*)+$/) do |row|
  Presstype.create(row.to_hash)
end

CSV.foreach(Rails.root.to_s+'/db/imports/outlets.csv',
            headers: true,
            skip_blanks: true,
            skip_lines: /^(?:,\s*)+$/) do |row|
  Outlet.create(row.to_hash)
end

CSV.foreach(Rails.root.to_s+'/db/imports/writers.csv',
            headers: true,
            skip_blanks: true,
            skip_lines: /^(?:,\s*)+$/) do |row|
            row = row.to_hash
            puts row
  # unless Writer.where(id: row["id"]).exists?
    Writer.new(row.to_hash).save(validate: false)
  # else
  #   puts "already exists"
  # end
end

CSV.foreach(Rails.root.to_s+'/db/imports/jobs.csv',
            headers: true,
            skip_blanks: true,
            skip_lines: /^(?:,\s*)+$/) do |row|
  Job.create(row.to_hash)
end

CSV.foreach(Rails.root.to_s+'/db/imports/genre_tags.csv',
            headers: true,
            skip_blanks: true,
            skip_lines: /^(?:,\s*)+$/) do |row|
  GenreTag.create(row.to_hash)
end

CSV.foreach(Rails.root.to_s+'/db/imports/presstype_tags.csv',
            headers: true,
            skip_blanks: true,
            skip_lines: /^(?:,\s*)+$/) do |row|
  PresstypeTag.create(row.to_hash)
end

Counter.create(name: "api_offset", count: 150)

puts "Created #{Country.count} Countries"
puts "Created #{Genre.count} Genres"
puts "Created #{Presstype.count} Presstypes"
puts "Created #{Job.count} Jobs"
puts "Created #{Outlet.count} Outlets"
puts "Created #{Writer.count} Writers"
puts "Created #{GenreTag.count} GenreTags"
puts "Created #{PresstypeTag.count} PresstypeTags"
