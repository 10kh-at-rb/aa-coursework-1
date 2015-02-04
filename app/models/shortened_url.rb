class ShortenedURL < ActiveRecord::Base
  validates :short_url, uniqueness: true
  validates :submitter_id, :long_url, :short_url, presence: true
  validates :long_url, length: { maximum: 255 }
  validate :max_submissions

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visit,
    class_name: 'Visit',
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many(:visitors, Proc.new { distinct }, through: :visit, source: :user_visit)
  has_many(:tags, through: :taggings, source: :tag)

  def self.random_code
    temp_code = SecureRandom::urlsafe_base64[0..15]
    while ShortenedURL.exists?(:short_url => temp_code)
      temp_code = SecureRandom::urlsafe_base64[0..15]
    end
    temp_code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedURL.create!(long_url: long_url, short_url: self.random_code, submitter_id: user.id)
  end

  def num_clicks
    self.visit.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visit.where(created_at: (10.minutes.ago..0.minutes.ago)).count
  end

  private

  def max_submissions
    recent_subs = self.class.where(created_at: (1.minutes.ago..0.minutes.ago), submitter_id: submitter_id).count
    if recent_subs > 5
     errors[:submitter_id] << "you cannot enter more than 5 links per minute"
    end

  end

end
