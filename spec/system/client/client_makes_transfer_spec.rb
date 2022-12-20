require 'rails_helper'

describe 'client makes a transfer' do
  it 'and is not authenticated' do
    visit root_path
    click_on 'Transferências'

    expect(page).to have_current_path new_client_session_path
  end

  it 'success' do
    client = create :client, name: 'Kilder Costa Filho', cash: 2000
    client2 = create :client, name: 'Joca Silva Moura', cpf_number: '09876543212', email: 'test@example.com', cash: 200

    login_as client
    visit root_path
    click_on 'Transferências'
    fill_in 'Nome', with: 'Joca Silva Moura'
    fill_in 'CPF', with: '09876543212'
    fill_in 'Valor', with: '1100'
    click_on 'CONFIRMAR'
    client.reload
    client2.reload

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Transferência realizado com sucesso'
    expect(client.cash).to eq 900 - get_hate_value(1100)
    expect(client2.cash).to eq 1300
    expect(client.account_statements.last.name).to eq 'Transferência'
    expect(client.account_statements.last.to).to eq 'Joca Silva Moura'.upcase
    expect(client.account_statements.last.moved_value).to eq '-1100'.to_i
    expect(client.account_statements.last.move_date).to eq Date.today
    expect(client2.account_statements.last.name).to eq 'Transferência'
    expect(client2.account_statements.last.from).to eq 'Kilder Costa Filho'.upcase
    expect(client2.account_statements.last.moved_value).to eq '1100'.to_i
    expect(client2.account_statements.last.move_date).to eq Date.today
  end

  it 'negative value' do
    client = create :client, name: 'Kilder Costa Filho', cash: 2000
    client2 = create :client, name: 'Joca Silva Moura', cpf_number: '09876543212', email: 'test@example.com', cash: 200

    login_as client
    visit root_path
    click_on 'Transferências'
    fill_in 'Nome', with: 'Joca Silva Moura'
    fill_in 'CPF', with: '09876543212'
    fill_in 'Valor', with: '-1100'
    click_on 'CONFIRMAR'
    client.reload
    client2.reload

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Transferência realizado com sucesso'
    expect(client.cash).to eq 900 - get_hate_value(1100)
    expect(client2.cash).to eq 1300
  end

  it 'fail if there is not enough cash' do
    client = create :client, name: 'Kilder Costa Filho', cash: 1000
    client2 = create :client, name: 'Joca Silva Moura', cpf_number: '09876543212', email: 'test@example.com', cash: 200

    login_as client
    visit root_path
    click_on 'Transferências'
    fill_in 'Nome', with: 'Joca Silva Moura'
    fill_in 'CPF', with: '09876543212'
    fill_in 'Valor', with: '1100'
    click_on 'CONFIRMAR'
    client.reload
    client2.reload

    expect(page).to have_content 'Você não tem dinheiro suficiente'
    expect(client.cash).to eq 1000
    expect(client2.cash).to eq 200
  end
end

def get_hate_value(transfer_value)
  hate_value = Time.now.on_weekday? && (9..18).include?(DateTime.now.hour) ? 5 : 7
  hate_value + transfer_value >= 1000 ? 10 : 0
end
