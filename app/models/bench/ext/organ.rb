module Bench
  module Ext::Organ
    extend ActiveSupport::Concern

    included do
      has_many :bench_provides, class_name: 'Bench::Provide', foreign_key: :provider_id
      has_many :facilitate_provides, class_name: 'Bench::FacilitateProvide', through: :bench_provides
    end

  end
end
