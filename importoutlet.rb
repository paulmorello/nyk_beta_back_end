require 'csv'

csv_text = File.read('/Dev/Client/Solitare/nyk_app/import/Outlets.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  Outlet.create!(row.to_hash)
end
