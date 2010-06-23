module KaruiOshaberi
  seeder = Ramaze.options.roots[0] + '/seed'
  puts seeder
  if Sequel::Migrator.run(DB, seeder) 
      Ramaze::Log.info "Migrating..."
  end

end
