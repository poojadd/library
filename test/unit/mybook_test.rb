# == Schema Information
#
# Table name: mybooks
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  price        :float
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  mysubject_id :integer
#

require 'test_helper'

class MybookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
