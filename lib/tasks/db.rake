namespace :db do

  desc "Truncate data tables"
  task :truncate => :environment do
    dbc = ActiveRecord::Base.configurations
    ActiveRecord::Base.establish_connection(dbc[Rails.env])
    skip_tables = %W(schema_migrations static_data)  #add tables which is not truncate
    tables = ActiveRecord::Base.connection.tables
    tables.each do |table|
      next if skip_tables.include?(table)
      puts "##### truncate table :: #{table}"
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table};")
    end
  end

  desc "Truncate all data tables"
  task :truncate_all => :environment do
    dbc = ActiveRecord::Base.configurations
    ActiveRecord::Base.establish_connection(dbc[Rails.env])
    tables = ActiveRecord::Base.connection.tables
    tables.each do |table|
      puts "##### truncate table :: #{table}"
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table};")
    end
  end
end