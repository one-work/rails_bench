module Bench
  class FacilitateResell < ApplicationRecord
    include Trade::Ext::Good if defined? RailsTrade
    include Model::FacilitateResell
  end
end
