################################################################################
# Model:  Partner
#
# Purpose:
#
# Partner attributes:
#   name      - string,  not NULL, unique
#   code      - string,  not NULL, unique
#   kind      - enum
#   role      - enum
#   url       - ustring
#   status    - enum { active (0) | archived (1) }
#   comment   - text
#
#  16.12.2021 ZT
################################################################################
class Partner < ApplicationRecord
  include ImagesHandleable

  has_many :details_set
  
  enum kind:   %w(ЗАО ИП ОАО ООО ПАО)
  enum role:   %w(supplier market_place service_provider subcontractor)
  enum status: %w(active archived)

  validates :name,  presence: true, uniqueness: true
  validates :code,  presence: true, uniqueness: true
end
