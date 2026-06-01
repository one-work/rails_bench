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
      belongs_to :provide

      has_many :facilitatings, primary_key: [:facilitate_id, :provide_id], foreign_key: [:facilitate_id, :provide_id]

      before_save :sync_seller, if: -> { provide_id_changed? }
      before_save :sync_from_facilitate, if: -> { faciliate_id_changed? }
      after_save :init_logo, if: -> { saved_change_to_facilitate_id? && facilitate }
    end

    def sync_seller
      self.seller = provide.provider
    end

    def sync_from_facilitate
      self.name = facilitate.name
    end

    def init_logo
      self.logo.attach facilitate.logo_blob unless logo.attached?
    end

  end
end
