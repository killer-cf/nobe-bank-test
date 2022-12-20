require 'rails_helper'

describe 'client requests statement' do
  it 'and is not authenticated' do
    client = create :client
    stt1 = create(:account_statement, name: 'Déposito', move_date: 3.day.ago, moved_value: 3300, client:)
    stt2 = create(:account_statement, name: 'Saque', move_date: 2.day.ago, moved_value: -100, client:)
    stt3 = create(:account_statement, name: 'Saque', move_date: 1.day.ago, moved_value: -500, client:)
    stt4 = create(:account_statement, name: 'Déposito', move_date: Date.today, moved_value: 1000, client:)

    visit root_path
    fill_in 'Data Inicial', with: 3.day.ago
    fill_in 'Data Final', with: 1.day.ago
    click_on 'Solicitar extrato'

    expect(page).to have_current_path new_client_session_path
    expect(page).not_to have_content "Déposito | R$ 3.300,00 | id: #{stt1.id} | Data: #{stt1.move_date}"
    expect(page).not_to have_content "Saque | R$ -100,00 | id: #{stt2.id} | Data: #{stt2.move_date}"
    expect(page).not_to have_content "Saque | R$ -500,00 | id: #{stt3.id} | Data: #{stt3.move_date}"
    expect(page).not_to have_content "Déposito | R$ 1.000,00 | id: #{stt4.id} | Data: #{stt4.move_date}"
    expect(page).not_to have_content 'Nenhuma movimentação encontrada'
  end

  it 'filtered by initial and end date' do
    client = create :client
    stt1 = create(:account_statement, name: 'Déposito', move_date: 3.day.ago, moved_value: 3300, client:)
    stt2 = create(:account_statement, name: 'Saque', move_date: 2.day.ago, moved_value: -100, client:)
    stt3 = create(:account_statement, name: 'Saque', move_date: 1.day.ago, moved_value: -500, client:)
    stt4 = create(:account_statement, name: 'Déposito', move_date: Date.today, moved_value: 1000, client:)

    login_as client
    visit root_path
    fill_in 'Data Inicial', with: 3.day.ago
    fill_in 'Data Final', with: 1.day.ago
    click_on 'Solicitar extrato'

    expect(page).to have_content "Déposito | R$ 3.300,00 | id: #{stt1.id} | Data: #{stt1.move_date}"
    expect(page).to have_content "Saque | R$ -100,00 | id: #{stt2.id} | Data: #{stt2.move_date}"
    expect(page).to have_content "Saque | R$ -500,00 | id: #{stt3.id} | Data: #{stt3.move_date}"
    expect(page).not_to have_content "Déposito | R$ 1.000,00 | id: #{stt4.id} | Data: #{stt4.move_date}"
  end

  it 'and not sees statements of another clients' do
    client = create :client
    client2 = create :client, cpf_number: '09876543212', email: 'test@example.com'
    stt1 = create(:account_statement, name: 'Déposito', move_date: 3.day.ago, moved_value: 3300, client:)
    stt2 = create(:account_statement, name: 'Saque', move_date: 2.day.ago, moved_value: -100, client:)
    stt3 = create(:account_statement, name: 'Saque', move_date: 1.day.ago, moved_value: -500, client:)
    stt4 = create(:account_statement, name: 'Déposito', move_date: Date.today, moved_value: 1000, client:)
    stt5 = create(:account_statement, name: 'Saque', move_date: 3.day.ago, moved_value: 2000, client: client2)
    stt6 = create(:account_statement, name: 'Déposito', move_date: 2.day.ago, moved_value: -600, client: client2)

    login_as client
    visit root_path
    fill_in 'Data Inicial', with: 3.day.ago
    fill_in 'Data Final', with: 1.day.ago
    click_on 'Solicitar extrato'

    expect(page).to have_content "Déposito | R$ 3.300,00 | id: #{stt1.id} | Data: #{stt1.move_date}"
    expect(page).to have_content "Saque | R$ -100,00 | id: #{stt2.id} | Data: #{stt2.move_date}"
    expect(page).to have_content "Saque | R$ -500,00 | id: #{stt3.id} | Data: #{stt3.move_date}"
    expect(page).not_to have_content "Déposito | R$ 1.000,00 | id: #{stt4.id} | Data: #{stt4.move_date}"
    expect(page).not_to have_content "Saque | R$ 2.000,00 | id: #{stt5.id} | Data: #{stt5.move_date}"
    expect(page).not_to have_content "Déposito | R$ 600,00 | id: #{stt6.id} | Data: #{stt6.move_date}"
  end

  it 'and theres no results' do
    client = create :client

    login_as client
    visit root_path
    fill_in 'Data Inicial', with: 3.day.ago
    fill_in 'Data Final', with: 1.day.ago
    click_on 'Solicitar extrato'

    expect(page).to have_content 'Nenhuma movimentação encontrada'
  end
end
