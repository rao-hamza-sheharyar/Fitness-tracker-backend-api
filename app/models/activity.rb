class Activity < ApplicationRecord
     # set validation rules from our form inputs
     validates :name, :title, :description, :distance,
                :duration, :elevation, :date, :time, :exertion,  presence: true
end
