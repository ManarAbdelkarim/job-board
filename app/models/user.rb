class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, maximum: 20 }

  has_many :job_applications
  has_many :job_posts, through: :job_applications

  before_save :default_admin_value

  private

  def default_admin_value
    self.admin ||= false
  end

end
