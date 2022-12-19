class TransactionsController < ApplicationController
  before_action :authenticate_client!, only: %i[withdraw send_withdraw]

  def deposit; end

  def send_deposit
    value = params[:value].to_i
    value *= -1 if value.negative?

    client = Client.find_by(name: params[:name].upcase, cpf_number: params[:cpf])
    if client
      client.cash += value
      redirect_to(root_path, notice: 'Déposito realizado com sucesso') if client.save
    else
      flash.now[:alert] = 'Dados incorretos ou cliente inexistente'
      render :deposit
    end
  end

  def withdraw; end

  def send_withdraw
    value = params[:value].to_i
    value *= -1 if value.negative?

    if current_client.cash >= value
      current_client.cash -= value
      current_client.save
      redirect_to root_path, notice: 'Saque realizado com sucesso'
    else
      flash.now[:alert] = 'Saldo insuficiênte'
      render :withdraw
    end
  end
end
