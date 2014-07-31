class Cat < ActiveRecord::Base

  COLORS = ["black", "brown", "orange", "brownish-orange" ,"calico", "mauve"]

  has_many(
    :rental_requests,
    :class_name => "CatRentalRequest",
    :foreign_key => :cat_id,
    :primary_key => :id,
    :dependent => :destroy
  )

  belongs_to(
    :owner,
    :class_name => "User",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  validates :age, :birthdate, :color, :name, :sex, :description, presence: true
  validates :age, numericality: true
  validates :color, inclusion: { in: COLORS,
    message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: ["M","F"], message: "%{value} is not a valid sex"}
  # validate :age_must_match_birthdate
  #
  # def age_must_match_birthdate
  #   if ((Time.now.to_date - Date.new(self[:birthdate])).to_i) / 365 != self[:age]
  #     errors[:age] << "doesn't match birthdate."
  #   end
  #end
end
