class Pal < ApplicationRecord
  validates :count, presence: true, uniqueness: true
end
