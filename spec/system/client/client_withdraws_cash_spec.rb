require 'rails_helper'

describe 'client withdraws cash' do
  it 'and is not authenticated' do
    create :client, name: 'Kilder Costa', cpf_number: '12345678901', email: 'costa.kilder@gmail.com', cash: 300

    visit root_path
    click_on 'Saque'

    expect(page).to have_current_path new_client_session_path
  end

  it 'success' do
    client = create :client, name: 'Kilder Costa', cpf_number: '12345678901', email: 'costa.kilder@gmail.com', cash: 300

    login_as client
    visit root_path
    click_on 'Saque'
    fill_in 'Valor', with: '200'
    click_on 'CONFIRMAR'
    client.reload

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Saque realizado com sucesso'
    expect(client.cash).to eq 100
  end

  it 'negative value' do
    client = create :client, name: 'Kilder Costa', cpf_number: '12345678901', email: 'costa.kilder@gmail.com', cash: 300

    login_as client
    visit root_path
    click_on 'Saque'
    fill_in 'Valor', with: '-200'
    click_on 'CONFIRMAR'
    client.reload

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Saque realizado com sucesso'
    expect(client.cash).to eq 100
  end

  it 'and there is not enough cash' do
    client = create :client, name: 'Kilder Costa', cpf_number: '12345678901', email: 'costa.kilder@gmail.com', cash: 300

    login_as client
    visit root_path
    click_on 'Saque'
    fill_in 'Valor', with: '500'
    click_on 'CONFIRMAR'
    client.reload

    expect(page).to have_content 'Saldo insuficiênte'
    expect(client.cash).to eq 300
  end
end
