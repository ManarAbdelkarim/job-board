class CreateJobPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :job_posts do |t|
      t.string :title
      t.string :description
      t.timestamps
    end
  end
end

class JobPost < ApplicationRecord
  has_many :job_applications, dependent: :destroy
  has_many :users, through: :job_applications
end