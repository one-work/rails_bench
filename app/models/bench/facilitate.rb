module Bench
  class Facilitate < ApplicationRecord
    include Trade::Ext::Good if defined? RailsTrade
    include Model::Facilitate
    include Detail::Ext::Listing if defined? RailsDetail
  end
end
