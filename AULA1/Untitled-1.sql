CREATE DATABASE bankEX;
use bankEX;
use dbat1;

SELECT * FROM usuario;

INSERT INTO usuario VALUES (0,'carlos','061.822','2002-02-10T11:33:22','222-555','cliente' );

CREATE TABLE transacao(
id_transacao INTEGER PRIMARY KEY AUTO_INCREMENT,
id_conta_origem INTEGER,
id_conta_destino INTEGER,
tipo_transacao VARCHAR(20),
valor DECIMAL,
data_hora DATETIME,
detalhes TEXT, 
FOREIGN KEY (id_conta_origem) REFERENCES conta(id_conta),
FOREIGN KEY (id_conta_destino) REFERENCES conta(id_conta)
);