Sequel.migration do
  up do
    alter_table :channels do
      add_column :topic, String
      add_column :creator, String
    end
  end

  down do
    alter_table :channels do
      drop_column :topic
      drop_column :creator
    end
  end
end
