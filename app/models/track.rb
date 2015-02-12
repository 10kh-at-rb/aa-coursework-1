class Track < ActiveRecord::Base
  validates :name, :album_id, :track_type
  validates :track_type, inclusion: { in: %w(Bonus Regular) }

  belongs_to(
    :album,
    class_name: "Album",
    foreign_key: :album_id,
    primary_key: :id
  )

  has_one :band, through: :album, source: :band

end
