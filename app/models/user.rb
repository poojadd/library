# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_digest        :string(255)
#  remember_token         :string(255)
#  password_salt          :string(255)
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  image                  :string(255)
#  roles_mask             :integer
#

  #bundle exec annotate
class User < ActiveRecord::Base
  #acts_as_authentic
  attr_accessible :email, :name, :password, :password_confirmation, :image, :remote_image_url, :roles
  has_secure_password
  before_create { generate_token(:auth_token) }
  before_save :encrypt_password
  validates :name, presence: true, length: { maximum: 50 }
  has_many :assignments
  has_many :roles, :through => :assignments
  self.per_page = 10
  ROLES = %w[admin moderator author editor]

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness:  true

  validates :password, confirmation: true, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  mount_uploader :image, ImageUploader

  def self.authenticate(email, password)

    user = find_by_email(email)

    if user && user.password_digest == BCrypt::Engine.hash_secret(password, user.password_salt)
   #   session[:current_user_id] = user.id
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_digest   = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
  #  save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end


  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def has_role?(role)
    self.roles.count(:conditions => ['name = ?', role]) > 0
  end

  def add_role(role)
     if self.has_role?(role)
       return
     end
     self.roles << Role.find_by_name(role)
  end

def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end

end
