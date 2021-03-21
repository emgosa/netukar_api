class CreateEpisodes < ActiveRecord::Migration[6.1]
  def change
    create_table :episodes do |t|
      t.string :title, null: false
      t.text :plot, null: false
      t.integer :season_episode_number, null: false
      t.references :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
