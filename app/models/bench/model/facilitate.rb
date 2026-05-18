module Bench
  module Model::Facilitate
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :quantity, :integer, default: 1
      attribute :unified_quantity, :integer, default: 1
      attribute :unit, :string, default: '个'
      attribute :description, :string
      attribute :qr_prefix, :string
      attribute :published, :boolean, default: true

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :standard, optional: true
      belongs_to :facilitate_taxon, counter_cache: true, optional: true

      has_many :facilitate_provides, dependent: :destroy
      has_many :providers, through: :facilitate_provides
      has_many :facilitate_indicators, dependent: :destroy
      has_many :indicators, through: :facilitate_indicators
      has_many :facilitatings
      has_many :facilitators, dependent: :destroy
      has_many :members, through: :facilitators

      has_one_attached :logo
      has_many_attached :covers
      has_many_attached :images
    end

    def order_deliverable(item)
      rest = (item.number - item.facilitatings.count).to_i
      rest.times do
        facilitatings.build(item_id: item.id)
      end
      save
    end

  end
end
