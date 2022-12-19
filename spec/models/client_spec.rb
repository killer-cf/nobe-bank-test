require 'rails_helper'

RSpec.describe Client, type: :model do
  describe '#valid?' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:cpf_number) }

    it { is_expected.to validate_presence_of(:email) }
  end
end
