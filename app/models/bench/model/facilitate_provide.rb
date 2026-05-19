module Bench
  module Model::FacilitateProvide
    extend ActiveSupport::Concern

    included do
      attribute :note, :string
      attribute :default, :boolean
      attribute :facilitatings_count, :integer, default: 0
      attribute :facilitators_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :provider, class_name: 'Org::Organ', optional: true

      belongs_to :facilitate
      belongs_to :provide, counter_cache: true

      has_many :facilitatings, primary_key: [:facilitate_id, :provide_id], foreign_key: [:facilitate_id, :provide_id]
      has_many :facilitators, primary_key: [:facilitate_id, :provider_id], foreign_key: [:facilitate_id, :organ_id], inverse_of: :facilitate_provide
      has_many :task_templates, as: :tasking, dependent: :nullify
    end

  end
end
