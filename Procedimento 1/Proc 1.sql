create database Loja;

drop database Loja;

use Loja;

create table pessoa(
  idpessoa int NOT NULL ,
  nome varchar(255) NOT NULL  ,
  logradouro varchar(255) NOT  NULL  ,
  cidade varchar(255)NOT  NULL  ,
  estado char(2)NOT  NULL  ,
  telefone varchar(11)NOT  NULL  ,
  email varchar(255)NOT  NULL    ,
primary key(idpessoa));

create table pessoa_fisica (
  idpessoa int NOT NULL,
  cpf varchar(255)  NOT NULL,
  primary key (idpessoa),
  foreign key (idpessoa) references pessoa(idpessoa));

create table pessoa_juridica (
  idpessoa int NOT NULL,
  cnpj varchar(255)  NOT NULL,
  primary key (idpessoa),
  foreign key (idpessoa) references pessoa(idpessoa));

create table produto (
  idproduto int NOT NULL  ,
  nome varchar(255)  NOT NULL  ,
  quantidade varchar(255)  NOT NULL  ,
  preco_venda numeric(5,2)  NOT NULL    ,
primary key(idproduto));

create table usuario (
  idusuario int NOT NULL ,
  login varchar(255)   NOT NULL  ,
  senha varchar(255)   NOT NULL    ,
primary key(idusuario));

create table movimento (
  idmovimento int NOT NULL,
  Usuario_idUsuario int  NOT NULL  ,
  pessoa_idpessoa int  NOT NULL  ,
  produto_idproduto int  NOT NULL  ,
  quantidade int  NOT NULL  ,
  tipo char  NOT NULL  ,
  valorUnitario numeric(5,2)  NOT NULL    ,
primary key(idmovimento),
foreign key (Usuario_idUsuario) references usuario(idusuario),
foreign key (produto_idproduto) references produto(idproduto),
foreign key (pessoa_idpessoa) references pessoa(idpessoa));

create sequence seq_Pessoa
	as numeric
	start with 1
	increment by 1
	no cycle;
