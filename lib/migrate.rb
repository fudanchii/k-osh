module KaruiOshaberi
  seeder = Ramaze.options.roots[0] + '/seed'
  Sequel::Migrator.run(DB, seeder) 
  Ramaze::Log.info "Migrating..."
end
