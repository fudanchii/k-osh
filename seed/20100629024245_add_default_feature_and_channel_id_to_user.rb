Sequel.migration do
  up do
    alter_table :users do
      add_foreign_key :channel_id, :channels
    end
  end

  down do
    alter_table :users do
      drop_column :channel_id
    end
  end
end
