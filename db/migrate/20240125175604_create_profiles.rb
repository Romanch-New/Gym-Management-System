class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :profession, default: 'none'
      t.string :phone_number, limit: 15
      t.text :about, default: 'I am a member of Sweat Society App.'
      t.references :profileable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
