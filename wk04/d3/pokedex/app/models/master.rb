# == Schema Information
#
# Table name: masters
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  hometown   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Master < ActiveRecord::Base
  has_many :pokemon
end
