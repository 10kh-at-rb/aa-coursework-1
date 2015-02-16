class Goal < ActiveRecord::Base
  validates :title, :content, :user_id, presence: true
  validates :private, :completed, inclusion: { in: [true, false] }

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )






end
