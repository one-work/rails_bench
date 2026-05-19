# frozen_string_literal: true

module Bench
  module Model::FacilitateProvide
    extend ActiveSupport::Concern

    included do
      attribute :note, :string
      attribute :default, :boolean
      attribute :facilitatings_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :provide, counter_cache: true
      belongs_to :facilitate

      has_many :facilitatings, primary_key: [:facilitate_id, :provide_id], foreign_key: [:facilitate_id, :provide_id]
    end

  end
end
