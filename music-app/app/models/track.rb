class Track < ActiveRecord::Base
  validates :name, :album_id, :track_type, presence: true
  validates :track_type, inclusion: { in: %w(Bonus Regular) }
  validates :name, presence: true, length: { minimum: 1}

  belongs_to(
    :album,
    class_name: "Album",
    foreign_key: :album_id,
    primary_key: :id
  )

  has_many(
    :notes,
    class_name: "Note",
    foreign_key: :track_id,
    primary_key: :id
  )

  has_one :band, through: :album, source: :band

end
