################################################################################
# Model:  PartnerBank
#
# Purpose: Joint table Partner has_manu through
#
# PartnerBank attributes:
#   partner_id  - FK
#   bank_id     - FK
#   account     - string
#   comment     - string
#   status      - enum { active (0) | archived (1) }
#
#  25.12.2021 ZT
################################################################################
class PartnerBank < ApplicationRecord
  belongs_to :partner, required: true
  belongs_to :bank,    required: true

  enum status: %w(active archived)

  validates :account, uniqueness: true, format: {with: /\A[\d+]{20}\Z/, message: "must be 20 digits"}
  validates :partner, presence: true
  validates :bank,    presence: true
end
