# frozen_string_literal: true

class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  validates_numericality_of :position

  def self.not_positioned
    where(position: nil)
  end

  def return_used_placements
    tutorial
      .videos
      .where("id != #{id}")
      .order(:position)
      .pluck(:position)
  end

  def update_placement
    update(position: return_used_placements.max + 1)
  end
end
