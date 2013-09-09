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

require 'test_helper'

class BookUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
