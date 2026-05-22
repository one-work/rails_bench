module Bench
  module Model::FacilitateResell
    extend ActiveSupport::Concern

    included do
      attribute :note, :string
      attribute :price, :decimal
      attribute :facilitatings_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :seller, class_name: 'Org::Organ', optional: true

      belongs_to :facilitate
      belongs_to :provide, counter_cache: true

      has_many :facilitatings, primary_key: [:facilitate_id, :provide_id], foreign_key: [:facilitate_id, :provide_id]
    end

  end
end
