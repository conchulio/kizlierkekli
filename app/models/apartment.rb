class Apartment < ActiveRecord::Base
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites

  validates :title, presence: true
  validates :description, presence: true
  validates :cost, presence: true
  validates :deposit, presence: true
  validates :address, presence: true
  validates :currency, presence: true
  validates :user, presence: true

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  include PgSearch
  pg_search_scope :search_everything, 
    against: [:title, :description, :address],
    using: {
      tsearch: {
        prefix: true,
        # any_word: true,
        # sort_only: true
        },
    },
    associated_against: {
      user: [:name]
    },
    ignoring: :accents,
    order_within_rank: "apartments.updated_at DESC"
end
