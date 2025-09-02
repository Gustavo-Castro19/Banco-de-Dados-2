CREATE DATABASE aulaTeste;
use aulaTeste;


CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    salario DECIMAL(10,2),
    departamento VARCHAR(50)
);
	
    ALTER TABLE funcionarios 
    MODIFY nome VARCHAR(100) NOT NULL;
    
    ALTER TABLE funcionarios
    ADD CHECK (salario>0);
    
    ALTER TABLE funcionarios
    MODIFY departamento ENUM('TI','RH','Financeiro','Marketing');
   
    ALTER TABLE funcionarios
    ADD COLUMN email VARCHAR(150) UNIQUE;
    
    ALTER TABLE funcionarios
    MODIFY departamento VARCHAR(100);
    
   ALTER TABLE funcionarios
   DROP CHECK funcionarios_chk_1;
   
   ALTER TABLE funcionarios
   RENAME COLUMN salario TO salario_base;
   
  ALTER TABLE funcionarios 
  ADD CHECK (salario_base>0);
  
  ALTER TABLE funcionarios
  DROP COLUMN departamento; 
  
  CREATE TABLE projetos(
  id_projeto INTEGER AUTO_INCREMENT PRIMARY KEY ,
  nome VARCHAR(150) NOT NULL,
  orcamento DECIMAL,
  CHECK (orcamento>0)
  );
  
  ALTER TABLE funcionarios
  ADD COLUMN id_projeto INTEGER ;
  
  ALTER TABLE funcionarios
  ADD FOREIGN KEY (id_projeto) REFERENCES projetos(id_projeto);
  
  INSERT INTO funcionarios(id_funcionario, nome, salario_base, id_projeto) 
  VALUES(1,"Carlos",1232.34,1);
  
  INSERT INTO projetos(id_projeto, nome, orcamento) 
  VALUES(1,'projeto1',20000.34);
  
  INSERT INTO funcionarios(id_funcionario, nome, salario_base, id_projeto) 
  VALUES(1,"Carlos",1232.34,1);