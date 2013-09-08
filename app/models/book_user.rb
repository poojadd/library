# == Schema Information
#
# Table name: book_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  mybook_id  :integer
#  issuedate  :datetime
#  returndate :datetime
#  returned   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BookUser < ActiveRecord::Base
  has_many :users
  has_many :mybooks
  attr_accessible :user_id, :mybook_id, :issuedate, :returndate, :returned

end
