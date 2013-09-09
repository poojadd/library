# == Schema Information
#
# Table name: mysubjects
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Mysubject < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true
  has_many :mybooks
  self.per_page = 10
  has_many :tags, :as => :taggable


  def self.search(search, page)
    paginate :per_page => 10, :page => page,
             :conditions => ['name like ?', "%#{search}%"],
             :order => 'name'
  end


end
