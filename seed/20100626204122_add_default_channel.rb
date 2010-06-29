module KaruiOshaberi
  Sequel.migration do
    up do
      DB[:channels].insert(:name => "Main")
    end

    down do
      DB[:channels].filter(:name => "Main").delete
    end
  end
end
