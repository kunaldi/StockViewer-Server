require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

task :environment do
  ENV['RACK_ENV'] ||= 'development'
  require File.expand_path('../config/environment', __FILE__)
end

desc 'API Routes'
task routes: :environment do
  StockViewer::API.routes.each do |api|
    method = api.route_method.ljust(10)
    path   = api.route_path
    puts "     #{method} #{path}"
  end
end

desc 'Import CSV stock symbols into database'
task import_csv: :environment do
  abort 'Symbols already exist.' if Stock.exists?

  require 'csv'
  puts 'Importing CSV into database'

  fields = %i(symb name sector industry)

  CSV.open('config/companylist.csv', 'r').each do |row|
    stock = fields.each_with_index.inject({}) { |m, (e, i)| m[e] = row[i]; m }
    Stock.create!(stock)
  end

end