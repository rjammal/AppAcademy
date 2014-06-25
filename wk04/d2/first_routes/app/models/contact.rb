# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  email      :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  favorite   :boolean          default(FALSE), not null
#

class Contact < ActiveRecord::Base
  validates :name, :email, :user_id, presence: true
  validates :email, uniqueness: { scope: :user_id }
  
  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :user_id
  )
  
  has_many :contact_shares
  
  has_many :shared_users,
    through: :contact_shares,
    source: :user
    
  has_many :comments, as: :commentable
  
  def self.contacts_for_user_id(user_id)
    Contact
      .joins("LEFT OUTER JOIN 
                contact_shares ON contact_shares.contact_id = contacts.id")
      .where("contacts.user_id = (?)
                OR contact_shares.user_id = (?)", user_id, user_id)
      .distinct
      .select("contacts.*, contact_shares.favorite as share_fave")
  end
end
