module Bench
  class Facilitating < ApplicationRecord
    include Model::Facilitating
    include Trade::Ext::Good if defined? RailsTrade
  end
end
