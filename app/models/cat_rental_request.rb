class CatRentalRequest < ActiveRecord::Base
  belongs_to(
    :cat,
    :class_name => "Cat",
    :foreign_key => :cat_id,
    :primary_key => :id
  )

  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: ["PENDING", "APPROVED", "DENIED"] }
  validate :no_two_overlapping_requests, :if => :status_approved?

  def approve!
    CatRentalRequest.transaction do
      self.update!(status: "APPROVED")
      cat_rentals = CatRentalRequest.where("cat_id = ?", cat_id)
      cat_rentals.each do |rental|
        next if rental.id == id
        rental.deny!
      end
    end
  end

  def deny!
    self.update!(status: "DENIED")
  end

  def status_approved?
    status == "APPROVED"
  end

  def pending?
    status == "PENDING"
  end

  def no_two_overlapping_requests
    cat_rentals = CatRentalRequest.where("cat_id = ?", cat_id)
    cat_rentals.each do |rental|
      next if rental.id == id || rental.status != "APPROVED"
      unless (rental.start_date > end_date ||
        rental.end_date < start_date)
        errors[:rental_request] << "cannot overlap with another approved rental"
        break
      end
    end
  end
end
