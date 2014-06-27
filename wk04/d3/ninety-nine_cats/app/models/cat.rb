# == Schema Information
#
# Table name: cats
#
#  id         :integer          not null, primary key
#  age        :integer          not null
#  birth_date :date             not null
#  color      :string(255)      not null
#  name       :string(255)      not null
#  sex        :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer          not null
#

class Cat < ActiveRecord::Base
  COLORS = %w(brown black white grey orange)
  GENDERS = %w(M F)
  
  validates :age, :birth_date, :color, :name, :sex, presence: true
  validates :age, numericality: { only_integer: true }
  validates :sex, inclusion: { in: GENDERS}
  validates :color, inclusion: { in: COLORS}
  
  has_many :cat_rental_requests, dependent: :destroy 
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  
  

end
