require 'rails_helper'

describe 'client signs out of the system' do
  it 'success' do
    client = create :client, name: 'Kilder Costa', password: 'password123', email: 'costa.kilder@gmail.com'

    login_as client
    visit root_path
    click_on 'Encerrar sessão'

    expect(page).to have_current_path root_path
    expect(page).to have_content 'Saída efetuada com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Encerrar sessão'
    expect(page).not_to have_content 'Kilder Costa'
  end
end
