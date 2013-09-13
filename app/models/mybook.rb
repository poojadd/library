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

class Mybook < ActiveRecord::Base
  belongs_to :mysubject
  has_many :tags, :as => :taggable

  attr_accessible :title, :price, :description, :mysubject_id
  validates :title, :presence => true,
            :length => { :minimum => 5 }
  validates :price, :presence => true

  scope :availables, Proc.new {
    joins("left outer join book_users on book_users.mybook_id = mybooks.id").where("book_users.returned = ?", true)
  }



  def self.search(search)
    search_condition = "%" + search + "%"
    #search_id = BookUser.select("mybook_id")
    #ids = []
    #search_id.each do |id|
    #  ids <<  id[:mybook_id]
    #
    #end
    #
    #p '======================================='
    #p ids
    #p '======================================='

    find(:all, :conditions => ['title LIKE ? OR description LIKE ? ', search_condition, search_condition])
  end

=begin
  searchable do
    text :title
    text :tags do
      tags.map { |tag| tag.name }
    end
    float :price

  end
=end
end
