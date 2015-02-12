class Album < ActiveRecord::Base
  validates :name, :band_id, :album_type
  validates :album_type, inclusion: { in: %w(Live Studio) }

  belongs_to(
    :band,
    class_name: "Band",
    foreign_key: :band_id,
    primary_key: :id
  )

  has_many(
    :tracks,
    class_name: "Track",
    foreign_key: :album_id,
    primary_key: :id,
    dependent: :destroy
  )

end
