class TransactionsController < ApplicationController
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
end
