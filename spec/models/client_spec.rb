require 'rails_helper'

RSpec.describe Client, type: :model do
  describe '#valid?' do
    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_presence_of(:cpf_number) }

    it { is_expected.to validate_uniqueness_of(:cpf_number) }

    it { is_expected.to validate_length_of(:cpf_number).is_equal_to(11) }

    it { is_expected.to validate_numericality_of(:cash).is_greater_than_or_equal_to 0.0 }
  end
end
