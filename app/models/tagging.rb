class Tagging < ActiveRecord::Base
  validates :shortened_url_id, :tag_id, presence: true

  belongs_to(
    :short_url,
    class_name: 'ShortenedURL',
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  belongs_to(
    :tag,
    class_name: 'TagTopic',
    foreign_key: :tag_id,
    primary_key: :id
  )

end
