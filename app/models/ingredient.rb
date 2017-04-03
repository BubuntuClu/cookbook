class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :name, :measure, presence: true
end
