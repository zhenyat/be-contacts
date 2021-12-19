require "test_helper"

class PartnerTest < ActiveSupport::TestCase
  def setup
    @partner = Partner.new
  end

  context 'validations' do
    should validate_presence_of(:name)
    should validate_uniqueness_of(:name)
    should validate_presence_of(:code)
    should validate_uniqueness_of(:code)
    should validate_presence_of(:title)
    should validate_uniqueness_of(:title)
    should validate_presence_of(:inn)
    should validate_uniqueness_of(:inn).case_insensitive
    should validate_presence_of(:email)
    should validate_uniqueness_of(:email).case_insensitive
  end

  ###   Alternative uniqueness validation
  def test_name_should_be_unique
    @partner.name = 'horns-hooves'
    @partner.valid?
    assert_includes(@partner.errors[:name], 'has already been taken')
  end
end
