require 'rails_helper'

describe 'client signs up' do
  it 'success' do
    visit root_path
    click_on 'Criar conta'
    fill_in 'Nome', with: 'Kilder Costa'
    fill_in 'CPF', with: '12345678901'
    fill_in 'E-mail', with: 'kilder@example.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirmar senha', with: 'password'
    click_on 'Registrar-se'

    expect(page).to have_current_path root_path
    expect(page).to have_button 'Encerrar sessão'
    expect(page).to have_content 'Kilder Costa'.upcase
    expect(page).not_to have_link 'Entrar'
  end

  it 'with blank fields' do
    visit new_client_registration_path
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmar senha', with: ''
    click_on 'Registrar-se'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
    expect(page).to have_content 'CPF não pode ficar em branco'
  end

  it 'with incorrect fields' do
    visit new_client_registration_path
    fill_in 'Nome', with: 'Kilder'
    fill_in 'CPF', with: '12345678901'
    fill_in 'E-mail', with: 'kilderexample.com'
    fill_in 'Senha', with: '123'
    fill_in 'Confirmar senha', with: '123'
    click_on 'Registrar-se'

    expect(page).to have_content 'Senha é muito curto (mínimo: 6 caracteres)'
    expect(page).to have_content 'E-mail não é válido'
  end
end
