# Internet Gateway module

Este módulo es usado para crear Internet Gateways en VPCs de AWS. Puede ser llamado desde un módulo de componente de la propia librería o desde fuera de ella. Permite opciones configurables para selección de la VPC en la que será desplegado el Internet gateway. Además, permite la asignación de etiquetas personalizadas.

La composición de la etiqueta `Name` se lleva a cabo mediante el uso del módulo [naming](../../logics/naming/).

## Variables

| Input Variable  | type        | Required | default | Description                                            |
|-----------------|-------------|----------|---------|--------------------------------------------------------|
| m_name          | string      | yes      |         | Base name used by the Internet Gateway.                |
| m_vpc_id        | string      | yes      |         | The VPC ID where the Internet Gateway will be created. |
| m_tags          | map(string) | no       | {}      | Map with tags names and values.                        |

## Outputs

Output Variable | Type   | Description
----------------|--------|-------------------------------------------------------------
 igw_object     | object | The entire resource object of the created Internet Gateway.

## Usage

En este ejemplo, se crea un Internet Gateway con el nombre "igw-test", creado sobre una VPC y con dos etiquetas personalizadas. Este ejemplo muestra cómo llamar al módulo desde un módulo componente de la propia librería:

```terraform
module "internet_gateway" {
  source   = "../../resources/internetGateway"
  m_name   = "test"
  m_vpc_id = "vpc-xxxxxxx"
  m_tags   = {
    Environment = "develop"
    Project     = "example"
  }
}
```

Para llamar directamente a este módulo desde fuera de la librería sería de la siguiente forma:

```terraform
module "internet_gateway" {
  source          = "git@github.com:MoiVilella/tf_aws_networking_library//modules/resources/internetGateway?ref=<tag_version>"
  m_name   = "test"
  m_vpc_id = "vpc-xxxxxxx"
  m_tags   = {
    Environment = "develop"
    Project     = "example"
  }
}
```

**Nota:** Como se puede observar en la URL definida en el campo source hay que cambiar el valor `<tag_version>` por el tag de la versión de la librería que se deséa usar.