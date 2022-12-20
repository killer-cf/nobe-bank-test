require 'rails_helper'

describe 'User visit home page' do
  it 'from URL' do
    visit root_path

    expect(page).to have_content 'Nobe Bank'
    expect(page).to have_current_path root_path
  end

  it 'and sees his balance' do
    client = create :client, name: 'Kilder Costa', cpf_number: '12345678901', email: 'ckiler@gmail.com', cash: 1000

    login_as client
    visit root_path

    expect(page).to have_content 'Saldo: R$ 1.000,00'
  end
end
