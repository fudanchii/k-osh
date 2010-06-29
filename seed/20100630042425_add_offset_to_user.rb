Sequel.migration do
  up do
    alter_table :users do
      add_column :offset, :integer, :default => 0
    end
  end

  down do
    alter_table :users do
      drop_column :offset
    end
  end
end
