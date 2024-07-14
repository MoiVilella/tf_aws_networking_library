# NAT Gateway module

Este módulo es usado para crear NAT Gateways en subredes de AWS. Puede ser llamado desde un módulo de componente de la propia librería o desde fuera de ella. Permite opciones configurables para selección de la subred en la que será desplegado el NAT gateway. Además, permite la asignación de etiquetas personalizadas.

La composición de la etiqueta `Name` se lleva a cabo mediante el uso del módulo [naming](../../logics/naming/).

## Variables

| Input Variable  | type        | Required | default | Description                                                                       |
|-----------------|-------------|----------|---------|-----------------------------------------------------------------------------------|
| m_name          | string      | yes      |         | Base name used by the NAT Gateway.                                                |
| m_name_suffix   | string      | no       | null    | Suffix for the the NAT Gateway name. Useful to add extra information at the name. |
| m_subnet_id     | string      | yes      |         | The Subnet ID where the NAT Gateway will be created.                              |
| m_tags          | map(string) | no       | {}      | Map with tags names and values.                                                   |

## Outputs

Output Variable | Type   | Description
----------------|--------|--------------------------------------------------------
 nat_gateway    | object | The entire resource object of the created NAT Gateway.

## Usage

En este ejemplo, se crea un NAT Gateway con el nombre "nat-test-ew1a" y una Elastic IP asociada a este NAT, desplegada sobre una subred pública y dos etiquetas personalizadas. Este ejemplo muestra cómo llamar al módulo desde un módulo componente de la propia librería:

```terraform
module "nat_gateway" {
  source          = "../../resources/natGateway"
  m_name        = "test"
  m_name_suffix = "ew1a"
  m_subnet_id   = "subnet-xxxxxxx"
  m_tags        = {
    Environment = "develop"
    Project     = "example"
  }
}
```

Para llamar directamente a este módulo desde fuera de la librería sería de la siguiente forma:

```terraform
module "nat_gateway" {
  source          = "git@github.com:MoiVilella/tf_aws_networking_library//modules/resources/natGateway?ref=<tag_version>"
  m_name        = "test"
  m_name_suffix = "ew1a"
  m_subnet_id   = "subnet-xxxxxxx"
  m_tags        = {
    Environment = "develop"
    Project     = "example"
  }
}
```

**Nota:** Como se puede observar en la URL definida en el campo source hay que cambiar el valor `<tag_version>` por el tag de la versión de la librería que se deséa usar.