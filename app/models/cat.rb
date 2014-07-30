class Cat < ActiveRecord::Base
  #instance varaibles for inclusion arrays?
  validates: :age, :birth_date, :color, :name, :sex, :description, presence: true
  vaildates: :age, numericality: true
  validates: :color, :inclusion, { in: ["black", "brown", "orange", "calico"],
    message: "#{value} is not a valid color" }
  validates: :sex, :inclusion, { in: ["M","F"] message: "#{value} is not a valid sex"}
end
