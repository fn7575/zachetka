class CreatePals < ActiveRecord::Migration[5.2]
  def change
    create_table :pals do |t|
      t.string :count
      t.string :res
      t.string :author
      t.string :photo
      t.string :shortDesc

      t.timestamp :time_in_second
    end
  end
end
