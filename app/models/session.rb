# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  password   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Session < ActiveRecord::Base
   attr_accessible :email, :password
  validates :email, :presence => true
  validate :password, :presence => true
end
