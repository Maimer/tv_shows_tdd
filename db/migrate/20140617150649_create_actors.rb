class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :name, null: false
    end

    remove_column :characters, :actor
    add_column :characters, :actor_id, :integer, null: false
  end
end
