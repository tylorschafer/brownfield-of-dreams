# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, allow_nil: true
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def self.in_system?(name)
    User.find_by(handle: name)
  end

end
