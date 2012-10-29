class CreateServiceProviders < ActiveRecord::Migration
  def up
    create_table :service_providers do |t|
      t.string :name
      t.string :title
      t.string :description
      t.boolean :status, :default => true

      t.timestamps
    end

    ServiceProvider.create({:name => "dentistry", :title => "Dentistry"})
    ServiceProvider.create({:name => "girl_scouts_troop_leader", :title => "Girl Scouts Central Texas"})
  end
  def down
    drop_table :service_providers
  end
end
