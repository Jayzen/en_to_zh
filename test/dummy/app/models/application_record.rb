class ApplicationRecord < ActiveRecord::Base
  include EnToZh::Translate
  self.abstract_class = true
end
