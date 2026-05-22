module Bench
  module Ext::Organ
    extend ActiveSupport::Concern

    included do
      attribute :start_at, :time
      attribute :finish_at, :time

      has_many :bench_provides, class_name: 'Bench::Provide', foreign_key: :provider_id
      has_many :facilitate_provides, class_name: 'Bench::FacilitateProvide', foreign_key: :provider_id
      has_many :facilitates, class_name: 'Bench::Facilitate', through: :facilitate_provides
    end

  end
end
