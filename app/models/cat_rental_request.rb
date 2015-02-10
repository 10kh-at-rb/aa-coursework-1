class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(APPROVED PENDING DENIED),
                                  message: "Status must be valid."}
  validate :overlapping_approved_requests

  private
  
  def overlapping_requests
    results = CatRentalRequest.all.where(['id != :id
      AND :cat_id = cat_id
      AND ((start_date BETWEEN :start_date AND :end_date)
      OR (end_date BETWEEN :start_date AND :end_date)
      OR (:start_date BETWEEN start_date AND end_date)
      OR (:end_date BETWEEN start_date AND end_date))',

      id: self.id,
      cat_id: self.cat_id,
      start_date: self.start_date,
      end_date: self.end_date])

    results
  end

  def overlapping_approved_requests
    results = overlapping_requests.where("status = 'APPROVED'")

    unless results.empty?
      start_date = results.first.start_date
      end_date = results.first.end_date
      errors[:base] <<
      "This is an overlapping approved request for" +
      " #{start_date} to #{end_date}."
    end
  end
end
