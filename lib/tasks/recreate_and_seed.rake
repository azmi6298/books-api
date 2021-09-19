desc "Recreate database"
namespace :db do
  task recreate_and_seed: :environment do
    puts "Recreate and seed database"
    Rake::Task['db:recreate'].invoke
    Rake::Task['seed_data'].invoke
  end
end