# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  band_id    :integer          not null
#  live       :boolean          not null
#  created_at :datetime
#  updated_at :datetime
#

class Album < ActiveRecord::Base
  validates :name, :band_id, :live, presence: true
  belongs_to :band
  has_many :tracks
end
