class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many(
    :submitted_urls,
    class_name: 'ShortenedURL',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visit,
    class_name: 'Visit',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(:visited_urls, Proc.new { distinct }, through: :visit, source: :shortened_url_visit)
end
