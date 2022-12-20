class TransactionsController < ApplicationController
  before_action :authenticate_client!, except: %i[deposit send_deposit]

  def deposit; end

  def send_deposit
    value = params[:value].to_i
    value *= -1 if value.negative?

    client = Client.find_by(name: params[:name].upcase, cpf_number: params[:cpf])
    if client
      client.cash += value
      AccountStatement.create!(name: 'Déposito', moved_value: value, move_date: Date.today, client:)
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
      AccountStatement.create!(name: 'Saque', moved_value: -value, move_date: Date.today, client: current_client)
      redirect_to root_path, notice: 'Saque realizado com sucesso' if current_client.save
    else
      flash.now[:alert] = 'Saldo insuficiênte'
      render :withdraw
    end
  end

  def transfer; end

  def send_transfer
    value = params[:value].to_i
    value *= -1 if value.negative?

    client = Client.find_by(name: params[:name].upcase, cpf_number: params[:cpf])
    if client && current_client.cash >= value
      transact('Transferência', client, value)
    else
      flash.now[:alert] = current_client.cash >= value ? 'Dados incorretos ou cliente inexistente' : 'Você não tem dinheiro suficiente'
      render :transfer
    end
  end

  def transact(name, client, value)
    client.cash += value
    current_client.cash -= value
    AccountStatement.create!(name:, moved_value: value, move_date: Date.today, from: current_client.name, client:)
    AccountStatement.create!(name:, moved_value: -value, move_date: Date.today, to: client.name, client: current_client)
    redirect_to(root_path, notice: "#{name} realizado com sucesso") if client.save && current_client.save
  end
end
