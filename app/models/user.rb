class User < ActiveRecord::Base
has_many :secrets
has_many :likes, dependent: :destroy
has_many :secrets_liked, through: :likes, source: :secret

  has_secure_password
  validates_presence_of :name, :email 
  validates_uniqueness_of :email
  before_save :downcase_email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  private
  def downcase_email
    self.email.downcase!
  end
end
