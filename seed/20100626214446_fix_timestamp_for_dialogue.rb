Sequel.migration do
  up do
    alter_table :dialogues do
      drop_column :when
      add_column :time_stamp, :timestamp, :default => Time.now
    end
  end

  down do
    alter_table :dialogues do
      drop_column :time_stamp
      add_column :when, :timestamp, :default => Time.now
    end
  end
end
