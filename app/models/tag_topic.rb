class TagTopic < ActiveRecord::Base
  validates :name, presence: true

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :tag_id,
    primary_key: :id
  )

  has_many(:urls, through: :taggings, source: :short_url)

  def most_popular_link
    self
      .urls
      .joins(:visit)
      .group("shortened_urls.id")
      .order("count(visits.user_id) desc")
      .first
    # most_popular_link = popular_links.first.first
    # ShortenedURL.find(most_popular_link)
  end
end
