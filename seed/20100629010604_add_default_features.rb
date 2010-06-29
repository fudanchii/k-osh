module KaruiOshaberi
Sequel.migration do
  up do
    a = DB[:channels][:name => "Main"]
    DB[:features].insert(:name => "CSystem")
    f = DB[:features][:name => "CSystem"]
    b = DB[:channels_features]
    b.insert(:channel_id => a[:id], :feature_id =>f[:id])
  end

  down do
    a = DB[:channels][:name => "Main"]
    f = DB[:features][:name => "CSystem"]
    b = DB[:channels_features].filter(:channel_id => a[:id]).filter(:feature_id => f[:id]).delete
    f.delete
  end
end
end
