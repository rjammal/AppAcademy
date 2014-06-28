# == Schema Information
#
# Table name: albums
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  band_id        :integer          not null
#  recording_type :string(255)      not null
#  created_at     :datetime
#  updated_at     :datetime
#

class Album < ActiveRecord::Base
  RECORDING_TYPES = ["studio", "live"]

  validates :name, :band_id, :recording_type, presence: true
  validates :name, uniqueness: {scope: :band_id}
  validates :recording_type, inclusion: { in: RECORDING_TYPES }

  has_many :tracks, dependent: :destroy
  belongs_to :band
end
