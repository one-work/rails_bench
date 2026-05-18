# frozen_string_literal: true

module Bench
  module Model::FacilitateProvide
    extend ActiveSupport::Concern

    included do
      attribute :note, :string
      attribute :default, :boolean

      belongs_to :provide, counter_cache: true
      belongs_to :facilitate
    end

  end
end
