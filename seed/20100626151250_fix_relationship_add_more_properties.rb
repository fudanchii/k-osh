Sequel.migration do
  up do
    alter_table :users do
      add_column :last_ping, :timestamp, :default => Time.now
    end

    alter_table :dialogues do
      drop_column :content
      drop_column :nick
      add_column :ct, String
      add_column :target, String, :default => "all"
      add_column :context, String, :default => "chat"
      add_column :when, :timestamp, :default => Time.now
      add_foreign_key :user_id, :users
    end

    drop_table :users_dialogues
  end

  down do
    alter_table :users do
      drop_column :last_ping
    end

    alter_table :dialogues do
      add_column :content, String
      drop_column :ct
      drop_column :target
      drop_column :context
      drop_column :when
    end

    create_table :users_dialogues do
      foreign_key :user_id
      foreign_key :dialogue_id
    end
  end
end
