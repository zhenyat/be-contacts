################################################################################
# Model:  Partner
#
# Partner attributes:
#   name      - string,  not NULL, unique
#   code      - string,  not NULL, unique
#   title     - string,  not NULL, unique
#   kind      - enum {zao | individual | oao | ooo (default) | pao}
#   role      - enum {supplier (default) | market_place | service_provider | subcontractor}
#   phone     - string
#   email     - string,  not NULL, unique (assigned with dummy value if not existin)
#   url       - string
#   inn       - string,  not NULL, unique 
#   kpp       - string
#   ogrn      - string, not null, unique for kind != 'individual'
#   ogrnip    - string, not null, unique for kind = 'individual'
#   okpo      - string
#   okato     - string
#   certificate_number - string
#   certificate_date   - date
#   status    - enum { active (0) | archived (1) }
#   comment   - text
#
#   17.12.2021  ZT
#   20.12.2021  Last update
################################################################################
class Partner < ApplicationRecord
  include TranslateEnum

  include Emailable
  include ImagesHandleable
  
  has_many :addresses
  has_many :contacts
  has_many :phones

  enum kind:   %w(zao individual oao ooo pao) #%w(ЗАО ИП ОАО ООО ПАО)
  enum role:   %w(supplier market_place service_provider subcontractor)
  enum status: %w(active archived)

  translate_enum :kind
  translate_enum :role

  before_validation :generate_dummy_email

  validates :name,    presence: true, uniqueness: true 
  validates :code,    presence: true, uniqueness: true
  validates :title,   presence: true, uniqueness: true
  validates :inn,     presence: true, uniqueness: {case_sensitive: false} 
  validates :ogrn,    presence: true, uniqueness: true, format: {with: /\A[\d+]{13}\Z/, message: 'must be 13 digits'}, if: -> {!individual?}
  validates :ogrnip,  presence: true, uniqueness: true, format: {with: /\A[\d+]{15}\Z/, message: 'must be 15 digits'}, if: -> {individual?}
  validates :kpp,     uniqueness: true, format: {with: /\A[\d+]{9}\Z/, message: "must be 9 digits"}, if: -> {kpp.present?}

  validate :inn_digits_length
  validate :individual_enterpreuner_orgnip
  validate :legal_ogrn
  validate :okpo_digits_length

  def ogrn_control_digit_test_passed? ogrn
    factor = ogrn.length - 2      # 11 for OGRN; 13 for OGRNIP
    control_digit = ogrn[-1].to_i # Last OGRN digit is the control digit
    value = ogrn.chop.to_i        # all first digits without the last one
    value - (value / factor * factor) == control_digit
  end

  def individual_enterpreuner_orgnip
    if individual?
      # errors.add(:ogrnip, "apply OGRNIP")      unless ogrnip.present?
      errors.add(:ogrn, "OGRN is not allowed")  if ogrn.present?
      errors.add(:ogrnip, "control digit test not passed") unless ogrn_control_digit_test_passed?(ogrnip)
    end
  end

  def inn_digits_length
    if individual?   # 12 digit
      # errors.add(:inn, I18n.t('errors.messages.length')) unless (inn =~ /\A[\d+]{12}\Z/)
      errors.add(:inn, I18n.t('errors.attributes.inn.length')) unless (inn =~ /\A[\d+]{12}\Z/)
      # errors.add(:inn, 'must be 12 digits') unless (inn =~ /\A[\d+]{12}\Z/)
    else             # 10 digits
      errors.add(:inn, 'must be 10 digits') unless (inn =~ /\A[\d+]{10}\Z/)
    end
  end

  def legal_ogrn
    if !individual?
      errors.add(:ogrnip, "OGRNIP is not allowed")  if ogrnip.present?
      if ogrn.present?
        errors.add(:ogrn, "control digit test not passed") unless ogrn_control_digit_test_passed?(ogrn)
      end
    end
  end

  def okpo_digits_length
    if okpo.present?
      if individual?   # 12 digits
        errors.add(:okpo, 'must be 10 digits') unless okpo =~ /\A[\d+]{10}\Z/
      else             # 10 digits
        errors.add(:okpo, 'must be 8 digits')  unless okpo =~ /\A[\d+]{8}\Z/
      end
    end
  end

  private
  def generate_dummy_email  # email MUST be assigned if not existing
    # 'self' - must be used here! (?)
    self.email = "#{self.code}@dummy.su" if self.email.blank? # if email is nil or ''
  end
end
