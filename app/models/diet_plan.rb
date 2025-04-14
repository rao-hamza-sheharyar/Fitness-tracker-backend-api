class DietPlan < ApplicationRecord
  belongs_to :user

  has_many :meals, dependent: :destroy

  accepts_nested_attributes_for :meals, allow_destroy: true
end
