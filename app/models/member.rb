class Member < ActiveRecord::Base

  ratyrate_rater

	has_many :ads

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
