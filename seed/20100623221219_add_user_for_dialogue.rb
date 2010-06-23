Sequel.migration do
  up do
    alter_table :dialogues do
      add_column :nick, String
    end
  end

  down do
    alter_table :dialogues do
      drop_column :nick
    end
  end
end
