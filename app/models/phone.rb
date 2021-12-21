################################################################################
# Model:  Phone
#
# Purpose:
#
# Phone attributes:
#   number             - number:  string
#   kind             - kind:  integer
#   status            - status:         enum { active (0) | archived (1) }
#
#  21.12.2021 ZT
################################################################################
class Phone < ApplicationRecord
  include TranslateEnum

  enum kind:   %w(mobile home work)
  enum status: %w(active archived)

  translate_enum :kind
  translate_enum :status
end
