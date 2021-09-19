desc "Recreate database"
namespace :db do
  task recreate: :environment do
    puts "Recreate database"
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
  end
end