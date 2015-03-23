class ContactShare < ActiveRecord::Base
  validates :user_id, presence: true, uniqueness: {:scope => :contact_id}
  validates :contact_id, presence: true

  belongs_to(
    :user,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "User"
  )

  belongs_to(
    :contact,
    foreign_key: :contact_id,
    primary_key: :id,
    class_name: "Contact"
  )

  # has_many :comments, :as => :commentable
end
