require 'rails_helper'

describe 'client edits account' do
  it 'success' do
    client = create :client, name: 'Kilder Costa', password: 'password123', email: 'costa.kilder@gmail.com'

    login_as client
    visit root_path
    click_on 'Editar dados da conta'
    fill_in 'Nome', with: 'Kilder Costa Filho'
    fill_in 'CPF', with: '12345678902'
    fill_in 'E-mail', with: 'kilder123@example.com'
    fill_in 'Senha', with: 'password999'
    fill_in 'Confirmar senha', with: 'password999'
    fill_in 'Senha atual', with: 'password123'
    click_on 'Salvar'
    client.reload

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Kilder Costa Filho'
    expect(client.email).to eq 'kilder123@example.com'
    expect(client.cpf_number).to eq '12345678902'
  end

  it 'with incorrect actual password' do
    client = create :client, name: 'Kilder Costa', password: 'password123', email: 'costa.kilder@gmail.com'

    login_as client
    visit root_path
    click_on 'Editar dados da conta'
    fill_in 'Nome', with: 'Kilder Costa Filho'
    fill_in 'CPF', with: '12345678902'
    fill_in 'E-mail', with: 'kilder123@example.com'
    fill_in 'Senha', with: 'password999'
    fill_in 'Confirmar senha', with: 'password999'
    fill_in 'Senha atual', with: '1212313'
    click_on 'Salvar'
    client.reload

    expect(page).to have_content 'Senha atual não é válido'
    expect(client.email).to eq 'costa.kilder@gmail.com'
  end

  it 'with blank fields' do
    client = create :client, name: 'Kilder Costa', password: 'password123', email: 'costa.kilder@gmail.com'

    login_as client
    visit root_path
    click_on 'Editar dados da conta'
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmar senha', with: ''
    fill_in 'Senha atual', with: 'password123'
    click_on 'Salvar'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'CPF não pode ficar em branco'
  end

  it 'with incorrect fields' do
    client = create :client, name: 'Kilder Costa', password: 'password123', email: 'costa.kilder@gmail.com'

    login_as client
    visit root_path
    click_on 'Editar dados da conta'
    fill_in 'E-mail', with: 'kidlerlk.com'
    fill_in 'Senha', with: '1213'
    fill_in 'Confirmar senha', with: '1234'
    fill_in 'Senha atual', with: 'password123'
    click_on 'Salvar'

    expect(page).to have_content 'Senha é muito curto (mínimo: 6 caracteres)'
    expect(page).to have_content 'E-mail não é válido'
  end

  it 'close account' do
    client = create :client, name: 'Kilder Costa', password: 'password123', email: 'costa.kilder@gmail.com'

    login_as client
    visit root_path
    click_on 'Editar dados da conta'
    click_on 'Encerrar minha conta'
    client.reload

    expect(client.persisted?).to eq true
    expect(client).to be_closed_account
    expect(page).to have_current_path root_path
    expect(page).not_to have_content('Kilder Costa')
    expect(page).to have_link('Entrar')
  end
end
