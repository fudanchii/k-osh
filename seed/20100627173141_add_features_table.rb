Sequel.migration do
  up do
    create_table :features do
      primary_key :id
      text :name
    end

    create_table :channels_features do
      foreign_key :channel_id
      foreign_key :feature_id
    end
  end

  down do
    drop_table :features
    drop_table :channels_features
  end
end
