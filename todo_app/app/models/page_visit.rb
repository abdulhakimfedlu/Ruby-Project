class PageVisit < ApplicationRecord
       validates :path, presence: true
       validates :total_visits, numericality: { greater_than_or_equal_to: 0 }
     end