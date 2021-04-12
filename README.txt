============================= DevOps Challenge =============================

A continuacion se muestra el listado de archivos que utilice (y algunos datos importantes de cada uno) para completar cada paso que se soilicita en el challenge. 


PASO 1: 
Crear una VPC y dos subredes publicas en dos zonas diferentes.

PROVIDER_AWS - definir AWS como proveedor

LOCALS – defini el nombre del proyecto para los tags
  project name = challenge

VPC – crear la vpc
  cidr = 10.0.0.0/16

PUBLIC_SUBNETS – crear las dos subredes publicas en dos zonas diferentes
Tome como zona principal US-EAST-1

  Subred publica 1 = 10.0.10.0/24
  availability_zone = "us-east-1a"

  Subred publica 2 = 10.0.11.0/24
  availability_zone = "us-east-1b"

IGW – definir el Gateway

ROUTE_TABLE – crear la tabla de rutas

NETWORK_ACL – control de trafico dentro de las subredes
  5 reglas de ingreso:

  rule 1 - ingress 100: from port = 22, to port = 22
  rule 2 - ingress 101: from port = 1024, to port = 65535
  rule 3 - ingress 102: from port = 80, to port = 80
  rule 4 - ingress 103: from port = 443, to port = 443
  rule 5 - ingress 104: from port = 8888, to port = 8888

  3 reglas de egreso:

  rule 1 - egress 100: from port = 1024, to port = 65535
  rule 2 - egress 101: from port = 80, to port = 80
  rule 3 - egress 102: from port = 443, to port = 443


=======================================================

PASO 2: Crear dos instancias EC2 y asignarlas a la VPC.


INSTANCES – crear dos instancias y asignar una a cada subred
La ami que estoy usando para ambas es para Windows Server 2019

  instancia 1 = subred publica 1
  ami = ami-07817f5d0e3866d32
  instance_type = t2.micro

  instancia 2 = subred publica 2
  ami = ami-07817f5d0e3866d32
  instance_type = "t2.micro"


======================================================================

PASO 3: Crear una aplicación de balance de carga

LOAD_BALANCER – crear un balanceador de carga para las instanncias

SECURITY_GROUP – control de tráfico entrante y saliente

======================================================================

PASO 4: Instalar la app y configurarla

No lo tengo 



