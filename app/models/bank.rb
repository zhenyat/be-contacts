################################################################################
# Model:  Bank
#
# Purpose: Bank Requisites
#
# Bank attributes:
#   name            - string,  not NULL, unique
#   title           - string,  not NULL
#   brief_title     - string,  not NULL
#   legal_address   - string,  not NULL
#   postal_address  - string,  not NULL
#   phone           - string,  not NULL
#   email           - string,  not NULL, unique
#   url             - string,  not NULL, unique
#   bic             - string
#   corr_acc        - string
#   corr_acc_with   - string
#   inn             - string,  not NULL, unique 
#   kpp             - string
#   ogrn            - string, not null, unique
#   okpo            - string
#   okato           - string
#   comment         - string
#   status          - enum { active (0) | archived (1) }
#
#  21.12.2021 ZT
################################################################################
class Bank < ApplicationRecord
  include Emailable

  enum status: %w(active archived)

  validates :name,          presence: true, uniqueness: true
  validates :title,         presence: true, uniqueness: true
  validates :bic,           presence: true, uniqueness: true
  validates :corr_acc,      presence: true, uniqueness: true
  validates :corr_acc_with, presence: true
  validates :inn,           presence: true, uniqueness: true
end
