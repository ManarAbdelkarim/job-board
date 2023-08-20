class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job_post
  validates :user, :job_post, presence: true
  validates :user, uniqueness: { scope: :job_post }

  enum status: { not_seen: 1, seen: 2 }
end
