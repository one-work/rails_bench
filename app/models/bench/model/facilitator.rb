module Bench
  module Model::Facilitator
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :description, :string

      belongs_to :facilitate
      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :member, class_name: 'Org::Member'

      belongs_to :facilitate_provide, foreign_key: [:facilitate_id, :organ_id], primary_key: [:facilitate_id, :provider_id], optional: true, inverse_of: :facilitators

      has_one_attached :avatar

      before_validation :sync_organ_from_member
    end

    def sync_organ_from_member
      self.organ = member.organ
    end

  end
end
