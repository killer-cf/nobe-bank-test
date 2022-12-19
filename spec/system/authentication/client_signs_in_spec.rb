require 'rails_helper'

describe 'client signs in' do
  it 'success' do
    create :client, name: 'Kilder Costa', password: 'password123', email: 'costa.kilder@gmail.com'

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'costa.kilder@gmail.com'
    fill_in 'Senha', with: 'password123'
    find('.actions').click_on 'Entrar'

    expect(page).to have_current_path root_path
    expect(page).to have_content('Kilder Costa'.upcase)
    expect(page).not_to have_link('Entrar')
    expect(page).to have_content('Autenticação efetuada com sucesso.')
  end

  it 'with blank fields' do
    create :client, name: 'Kilder Costa', password: 'password123', email: 'costa.kilder@gmail.com'

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    find('.actions').click_on 'Entrar'

    expect(page).to have_content 'E-mail ou senha inválidos.'
    expect(page).not_to have_content 'Autenticação efetuada com sucesso.'
  end

  it 'with incorrect fields' do
    create :client, name: 'Kilder Costa', password: 'password123', email: 'costa.kilder@gmail.com'

    visit new_client_session_path
    fill_in 'E-mail', with: 'kilderexample.com'
    fill_in 'Senha', with: '123'
    find('.actions').click_on 'Entrar'

    expect(page).not_to have_content 'Autenticação efetuada com sucesso.'
    expect(page).to have_content 'E-mail ou senha inválidos.'
  end
end
