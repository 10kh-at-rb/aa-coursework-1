class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question

  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one :question, through: :answer_choice, source: :question


  def sibling_responses
    if self.id.nil?
      self.question.responses
    else
      self.question.responses.where('responses.id != ?', self.id)
    end
  end

  private
  def respondent_has_not_already_answered_question
    current_user = self.user_id
    unless self.sibling_responses.where(user_id: current_user).empty?
      errors[:base] << 'Already responded to this question.'
    end
  end

end
