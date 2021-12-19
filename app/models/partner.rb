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
#   email     - string,  not NULL, unique 
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
#  17.12.2021 ZT
################################################################################
class Partner < ApplicationRecord
  include Emailable
  include ImagesHandleable
  
  has_many :addresses
  has_many :banks
  has_many :contacts
  has_many :phones

  enum kind:   %w(zao individual oao ooo pao) #%w(ЗАО ИП ОАО ООО ПАО)
  enum role:   %w(supplier market_place service_provider subcontractor)
  enum status: %w(active archived)

  before_create :generate_dummy_email

  validates :name,  presence: true, uniqueness: true 
  validates :code,  presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
  validates :inn,   presence: true, uniqueness: {case_sensitive: false} 

  validate :inn_digits_length
  validate :individual_enterpreuner_orgnip
  validate :kpp_digits_length
  validate :ogrn_digits_length
  validate :okpo_digits_length

  def ogrn_control_digit_test_passed? ogrn
    factor = ogrn.length - 2      # 11 for OGRN; 13 for OGRNIP
    control_digit = ogrn[-1].to_i # Last OGRN digit is the control digit
    value = ogrn.chop.to_i        # all first digits without the last one
    value - (value / factor * factor) == control_digit
  end

  def individual_enterpreuner_orgnip
    if individual?
      errors.add(:ogrnip, "apply OGRNIP")      unless ogrnip.present?
      errors.add(:ogrnip, "must be 15 digits") unless ogrnip =~ /\A[\d+]{15}\Z/
      errors.add(:ogrnip, "control digit test not passed") unless ogrn_control_digit_test_passed?(ogrnip)
    end
  end

  def inn_digits_length
    if individual?   # 12 digit
      errors.add(:inn, 'must be 12 digits') unless (inn =~ /\A[\d+]{12}\Z/)
    else             # 10 digits
      errors.add(:inn, 'must be 10 digits') unless (inn =~ /\A[\d+]{10}\Z/)
    end
  end

  def kpp_digits_length
    if kpp.present?  # 9 digits
      errors.add(:kpp, 'must be 12 digits') unless kpp =~ /\A[\d+]{9}\Z/
    end
  end

  def ogrn_digits_length
    if !individual? and ogrn.present?
      errors.add(:ogrn, "must be 13 digits") unless ogrn =~ /\A[\d+]{13}\Z/
      errors.add(:ogrn, "control digit test not passed") unless ogrn_control_digit_test_passed?(ogrn)
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
  def generate_dummy_email  # email MUST BE (at least dummy)
    # 'self' - must be used here! (?)
    self.email = "#{self.code}@dummy.su" if self.email.nil? or self.email.blank?
  end
end
