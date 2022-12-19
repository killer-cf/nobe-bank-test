class TransactionsController < ApplicationController
  def deposit; end

  def send_deposit
    client = Client.find_by(name: params[:name].upcase, cpf_number: params[:cpf])
    return unless client

    client.cash += params[:value].to_i

    redirect_to(root_path, notice: 'Déposito realizado com sucesso') if client.save
  end
end
