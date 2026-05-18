module Bench
  module Model::Provide
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :invite_token, :string, default: -> { SecureRandom.uuid }
      attribute :facilitate_provides_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ'
      belongs_to :provider, class_name: 'Org::Organ', optional: true

      has_many :facilitate_provides, dependent: :destroy
      accepts_nested_attributes_for :facilitate_provides

      validates :provider_id, uniqueness: { scope: :organ_id }, allow_blank: true
      validates :name, uniqueness: { scope: :organ_id }
    end

    def invite_url
      Rails.app.routes.url_for(
        controller: 'bench/board/organs',
        invite_token: invite_token,
        host: (organ.provider || organ).host
      )
    end

  end
end
