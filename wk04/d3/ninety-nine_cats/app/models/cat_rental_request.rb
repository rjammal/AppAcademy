# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string(255)      default("PENDING"), not null
#  created_at :datetime
#  updated_at :datetime
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in:  %w(PENDING APPROVED DENIED) }
  
  validate :overlapping_approved_requests
  
  before_validation :set_status
  
  belongs_to :cat
  belongs_to :user
  
  
  def approve!
    ActiveRecord::Base.transaction do
      overlapping_pending_requests.each do |pending|
        pending.deny!
      end
      self.status = "APPROVED"
      self.save!
    end
  end
  
  def deny!
    self.status = "DENIED"
    self.save!
  end
  
  def overlapping_requests
    CatRentalRequest
      .where("( (?) 
                BETWEEN 
                  start_date 
                  AND 
                  end_date) 
                OR
              ( (?) 
                BETWEEN 
                  start_date 
                  AND 
                  end_date)
                OR
              ( start_date
                BETWEEN
                  ?
                  AND
                  ?)", start_date, end_date, start_date, end_date)
      .where(cat_id: cat_id)
  end
  
  def overlapping_approved_requests
    overlap = overlapping_requests.where(status: 'APPROVED')
    
    if !overlap.empty?
      errors[:cat_id] << "is already booked"
    end
  end
  
  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end

  
  def set_status
    self.status ||= 'PENDING'
  end
  
end