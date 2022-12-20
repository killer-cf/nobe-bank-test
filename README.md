# Nobe Bank

## Como executar o projeto

### 1. Execute a configuração inicial

```text
bin/setup
```

```text
rails db:seed
```

### 2. Execute a aplicação em sua máquina( use no lugar de 'rails s')

```text
bin/dev
```

### 3. Acesse este endereço em seu navegador

```text
http://localhost:3000/
```

</br>

## Como executar os testes

```text
rspec
```

</br>

## Dependências do sistema

- ruby (3.1.0)

### Testes

- gem 'rspec-rails'
- gem 'factory_bot_rails'
- gem 'shoulda-matchers'

### Estilização

- gem 'tailwindcss-rails'

### Autenticação e autorização

- gem 'devise'
