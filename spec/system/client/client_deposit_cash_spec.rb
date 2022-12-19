require 'rails_helper'

describe 'client deposits cash' do
  it 'success' do
    client = create :client, name: 'Kilder Costa', cpf_number: '12345678901', email: 'costa.kilder@gmail.com', cash: 0.0

    visit root_path
    click_on 'Dépositos'
    fill_in 'Nome', with: 'Kilder Costa'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Valor', with: '200'
    click_on 'CONFIRMAR'
    client.reload

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Déposito realizado com sucesso'
    expect(client.cash).to eq 200
  end

  it 'negative value' do
    client = create :client, name: 'Kilder Costa', cpf_number: '12345678901', email: 'costa.kilder@gmail.com', cash: 0.0

    visit root_path
    click_on 'Dépositos'
    fill_in 'Nome', with: 'Kilder Costa'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Valor', with: '-200'
    click_on 'CONFIRMAR'
    client.reload

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Déposito realizado com sucesso'
    expect(client.cash).to eq 200
  end

  it 'incorrect fields' do
    client = create :client, name: 'Kilder Costa', cpf_number: '12345678901', email: 'costa.kilder@gmail.com', cash: 0.0

    visit root_path
    click_on 'Dépositos'
    fill_in 'Nome', with: 'Kilder KKK'
    fill_in 'CPF', with: '12345678901'
    fill_in 'Valor', with: '200'
    click_on 'CONFIRMAR'
    client.reload

    expect(page).to have_content 'Dados incorretos ou cliente inexistente'
    expect(client.cash).to eq 0.0
  end
end
