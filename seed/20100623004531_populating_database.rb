Sequel.migration do
  up do

    create_table :users do
      primary_key :id
      text :nick
    end

    create_table :channels do
      primary_key :id
      varchar :name
    end

    create_table :dialogues do
      primary_key :id
      text :content
      foreign_key :channel_id
    end

    create_table :users_dialogues do
      foreign_key :user_id
      foreign_key :dialogue_id
    end

  end

  down do
    drop_table :users
    drop_table :channels
    drop_table :dialogues
    drop_table :users_dialogues
  end
end
