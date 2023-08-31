  -- Criar o esquema lógico para o contexto de uma oficina. 
 
 -- Esquema Conceitual para uma Oficina de Veículos

-- Tabela de Clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    endereco VARCHAR(255),
    dt_cadastro DATE,
    email VARCHAR(100),
    CONSTRAINT unique_email UNIQUE (email)
);

-- Tabela de Veículos : detalhes sobre os veículos dos clientes.

CREATE TABLE veiculos (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anoFabricacao YEAR,
    placa VARCHAR(10) NOT NULL UNIQUE,
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabela de Serviços: registra os serviços realizados nos veículos.

CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT,
    data_servico DATE,
    descricao TEXT,
    valor DECIMAL(10, 2),
    CONSTRAINT fk_veiculo FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo)
);

-- Tabela de Pedidos
-- Esta tabela registra os pedidos de peças ou componentes.

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    status_pedido ENUM('Em andamento', 'Concluído') DEFAULT 'Em andamento',
    CONSTRAINT fk_cliente_pedido FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabela de Itens do Pedido
-- Esta tabela relaciona os produtos pedidos em cada pedido.

CREATE TABLE itensPedido (
    id_pedido INT,
    id_servico INT,
    quantidade INT DEFAULT 1,
    CONSTRAINT fk_pedido FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    CONSTRAINT fk_servico FOREIGN KEY (id_servico) REFERENCES servicos(id_servico)
);

-- Tabela de Situação do Pagamento
-- Esta tabela registra as situações de pagamento dos pedidos.

CREATE TABLE situacaoPagamento (
    id_pedido INT,
    data_pagamento DATE,
    valor_pago DECIMAL(10, 2),
    CONSTRAINT fk_pedido_pagamento FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

-- Tabela de Relatório de Serviços
-- Esta tabela registra o histórico de serviços feitos em cada veículo.

CREATE TABLE relatorioServicos (
    id_veiculo INT,
    data_entrada DATE,
    data_saida DATE,
    servico_realizado TEXT,
    CONSTRAINT fk_veiculo_relatorio FOREIGN KEY (id_veiculo) REFERENCES veiculos(id_veiculo)
);
------------------------------------------------------