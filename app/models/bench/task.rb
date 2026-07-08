module Bench
  class Task < ApplicationRecord
    include Model::Task
    include Com::Ext::Taxon
    if defined? RailsNotice
      include Notice::Ext::Notifiable
      include Notice::Ext::MemberNotifiable
    end
    if defined? RailsEvent
      include Eventual::Ext::Planned
    end
  end
end
