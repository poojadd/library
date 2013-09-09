# == Schema Information
#
# Table name: abilities
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Ability < ActiveRecord::Base
  # attr_accessible :title, :body
  include CanCan::Ability

  def initialize(user)
    user ||=  User.new
    p '*' * 50
     p user

    if user.role? :admin
      can :manage, :all
    else
      can :read, :all
      if user.role?(:author)
        can :create, Mybook
        can :destroy, Mybook
        can :update, Mybook do |book|
          book.try(:user) == user
      end

       end
    end

  end
end
