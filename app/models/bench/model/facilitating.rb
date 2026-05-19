module Bench
  module Model::Facilitating
    extend ActiveSupport::Concern

    included do
      attribute :start_at, :datetime
      attribute :finish_at, :datetime
      attribute :estimate_start_at, :datetime
      attribute :estimate_finish_at, :datetime
      attribute :extra, :json, default: {}
      attribute :confirmed, :boolean

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :user, class_name: 'Auth::User', optional: true
      belongs_to :member, class_name: 'Org::Member', optional: true
      belongs_to :wallet_payment, class_name: 'Trade::WalletPayment', optional: true
      belongs_to :item, class_name: 'Trade::Item', optional: true

      belongs_to :facilitate
      belongs_to :facilitator, optional: true
      belongs_to :provide, optional: true
      belongs_to :facilitate_provide, foreign_key: [:facilitate_id, :provide_id], primary_key: [:facilitate_id, :provide_id], counter_cache: true

      before_validation :sync_from_facilitate, if: -> { facilitate_id_changed? }
      before_validation :sync_from_facilitator, if: -> { facilitator_id_changed? }
      after_save_commit :send_notice, if: -> { (saved_changes.keys & ['member_id', 'start_at', 'finish_at']).present? }
    end

    def duration
      if start_at && finish_at
        ActiveSupport::Duration.build((finish_at - start_at).round).in_all[:minutes]
      else
      end
    end

    def sync_from_facilitate
      self.organ_id = facilitate.organ_id
      self.price = facilitate.price
    end

    def sync_from_facilitator
      self.member_id = facilitator.member_id
    end

    def enter_url
      Rails.app.routes.url_for(
        controller: 'bench/facilitatings',
        action: 'qrcode',
        id: self.id,
        host: item.organ.host
      )
    end

    def qrcode_enter_png
      QrcodeUtil.code_png(
        enter_url,
        border_modules: 0,
        fill: 'pink'
      )
    end

    def qrcode_enter_url
      QrcodeUtil.data_url(enter_url)
    end

    def user_url
      Rails.app.routes.url_for(
        controller: 'bench/facilitatings',
        action: 'user',
        id: self.id,
        host: item.organ.host
      )
    end

    def qrcode_user_url
      QrcodeUtil.data_url(user_url)
    end

    def send_notice
      broadcast_action_to(
        self,
        action: :update,
        target: "facilitating_#{id}",
        partial: 'bench/my/facilitatings/facilitating_preview',
        locals: { model: self }
      )
    end

  end
end
