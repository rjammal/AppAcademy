# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  album_id   :integer          not null
#  track_type :string(255)      not null
#  lyrics     :text
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
  TRACK_TYPES = ["bonus", "regular"]

  validates :name, :album_id, :track_type, presence: true
  validates :name, uniqueness: {scope: :album_id}
  validates :track_type, inclusion: { in: TRACK_TYPES }

  belongs_to :album
  has_one :band, through: :album, source: :band
  has_many :notes, dependent: :destroy
end
