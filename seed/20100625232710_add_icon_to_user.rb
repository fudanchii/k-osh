Sequel.migration do
  up do
    alter_table :users do
      add_column :icon, String
    end
  end

  down do
    alter_table :users do
      drop_column :icon
    end
  end
end
