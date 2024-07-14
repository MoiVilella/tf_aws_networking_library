# Subnet module

Este módulo es usado para crear Subredes en VPCs de AWS. Puede ser llamado desde un módulo de componente de la propia librería o desde fuera de ella. Permite opciones configurables para selección de zona de disponibilidad y si las interfaces de red obtienen IPs públicas por defecto. Además, permite la asignación de etiquetas personalizadas.

Este módulo generará dos etiquetas por defecto en todas las subredes que cree:
 - **SubnetType:** Especificará si la red ha sido pensada para ser pública o privada. Lo que significará que la tabla de rutas asociada a la subred enviará el tráfico a internét a través de un AWS Internet Gateway (pública) o a través de un AWS NAT Gateway (privada).
 - **SubnetAZ:** Contendrá una abreviación de la Zona de disponibilidad dentro de la región en la que la subred ha sido creada.

La composición de la etiqueta `Name` se lleva a cabo mediante el uso del módulo [naming](../../logics/naming/).

## Variables

| Input Variable  | type        | Required | default | Description                                                                  |
|-----------------|-------------|----------|---------|------------------------------------------------------------------------------|
| m_name          | string      | yes      |         | Base name used by the Subnet.                                                |
| m_subnet_type   | string      | yes      |         | Type of subnet. Accepted values are: [ public, private ]                     |
| m_vpc_id        | string      | yes      |         | The VPC ID where the subnet will be created.                                 |
| m_subnet_az     | string      | yes      |         | AWS region Availability Zone where the subnet will be created.               |
| m_cidr_block    | string      | yes      |         | IP CIDR block used by the Subnet. The CIDR block must contain the mask.      |
| m_public_subnet | bool        | no       | false   | A boolean flag to enable/disable that new network interfaces launched into the subnet should be assigned a public IP address. |
| m_tags          | map(string) | no       | {}      | Map with tags names and values.                                              |

## Outputs

Output Variable | Type   | Description
----------------|--------|---------------------------------------------------
 subnet_object  | object | The entire resource object of the created Subnet.

## Usage

En este ejemplo, se crea una Subnet con el nombre "mysubnet", un bloque CIDR de "10.0.0.0/20", configurada para ser de tipo público, en la zona de disponibilidad A de la región de Irlanda, habilitando que se asignen IPs públicas por defecto a las interfaces de red creadas dentro de la subred y dos etiquetas personalizadas. Este ejemplo muestra cómo llamar al módulo desde un módulo componente de la propia librería:

```terraform
module "subnet" {
  source          = "../../resources/subnet"
  m_name          = "mysubnet"
  m_vpc_id        = "vpc-xxxxxxxx"
  m_cidr_block    = "10.0.0.0/20"
  m_subnet_az     = "eu-west-1a"
  m_subnet_type   = "public"
  m_public_subnet = true
  m_tags = {
    Environment = "develop"
    Project     = "example"
  }
}
```

Para llamar directamente a este módulo desde fuera de la librería sería de la siguiente forma:

```terraform
module "vpc" {
  source          = "git@github.com:MoiVilella/tf_aws_networking_library//modules/resources/subnet?ref=<tag_version>"
  m_name          = "mysubnet"
  m_vpc_id        = "vpc-xxxxxxxx"
  m_cidr_block    = "10.0.0.0/20"
  m_subnet_az     = "eu-west-1a"
  m_subnet_type   = "public"
  m_public_subnet = true
  m_tags = {
    Environment = "develop"
    Project     = "example"
  }
}
```

**Nota:** Como se puede observar en la URL definida en el campo source hay que cambiar el valor `<tag_version>` por el tag de la versión de la librería que se deséa usar.