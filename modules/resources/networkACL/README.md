# Network ACL module

Este módulo es usado para crear Network ACLs en VPCs de AWS y asociarlarlas a subredes. Puede ser llamado desde un módulo de componente de la propia librería o desde fuera de ella. Permite gestionar las rutas asociadas a la tabla de rutas mediante un bloque dinámico a partir de un mapa de objetos. Además, permite la asignación de etiquetas personalizadas.

La composición de la etiqueta `Name` se lleva a cabo mediante el uso del módulo [naming](../../logics/naming/).

## Variables

| Input Variable  | type         | Required | default | Description                                                                   |
|-----------------|--------------|----------|---------|-------------------------------------------------------------------------------|
| m_name          | string       | yes      |         | Base name used by the Network ACL.                                            |
| m_name_suffix   | string       | no       | null    | Suffix for the Network ACL name. Useful to add extra information at the name. |
| m_vpc_id        | string       | yes      |         | The VPC ID where the network ACL will be created.                             |
| m_subnets_ids   | list(string) | no       | []      | List of subnet IDs to attatch to this network ACL.                            |
| [m_ingress_rules](#m_ingress_rules-objects) | map(object) | no | {} | Map with ingress rules to add into the Network AC             |
| [m_egress_rules](#m_egress_rules-objects) | map(object) | no | {} | Map with egress rules to add into the Network ACL.              |
| m_tags          | map(string)  | no       | {}      | Map with tags names and values.                                               |

### m_ingress_rules objects

The map key must be a number as string. This string will be converted into a number and used as rule number for ordering the rule.

| keys       | type   | Required | default | Description                                                                                      |
|------------|--------|----------|---------|--------------------------------------------------------------------------------------------------|
| action     | string | yes      |         | The action to take. Accepted values are: [ allow, deny ]                                         |
| from_port  | number | yes      |         | The from port to match.                                                                          |
| to_port    | number | yes      |         | The to port to match.                                                                            |
| protocol   | string | yes      |         | The protocol to match. If using the -1 'all' protocol, you must specify a from and to port of 0. |
| cidr_block | string | no       |         | The CIDR block to match. This must be a valid network mask.                                      |
| icmp_type  | number | no       | 0       | The ICMP type to be used.                                                                        |
| icmp_code  | number | no       | 0       | The ICMP type code to be used.                                                                   |

### m_egress_rules objects

The map key must be a number as string. This string will be converted into a number and used as rule number for ordering the rule.

| keys       | type   | Required | default | Description                                                                                      |
|------------|--------|----------|---------|--------------------------------------------------------------------------------------------------|
| action     | string | yes      |         | The action to take. Accepted values are: [ allow, deny ]                                         |
| from_port  | number | yes      |         | The from port to match.                                                                          |
| to_port    | number | yes      |         | The to port to match.                                                                            |
| protocol   | string | yes      |         | The protocol to match. If using the -1 'all' protocol, you must specify a from and to port of 0. |
| cidr_block | string | no       |         | The CIDR block to match. This must be a valid network mask.                                      |
| icmp_type  | number | no       | 0       | The ICMP type to be used.                                                                        |
| icmp_code  | number | no       | 0       | The ICMP type code to be used.                                                                   |

## Outputs

Output Variable | Type   | Description
----------------|--------|--------------------------------------------------------
 network_acl    | object | The entire resource object of the created Network ACL.

## Usage

En este ejemplo, se crea un network ACL con el nombre "acl-test-public", con una regla de entrada y otra de salida configuradas para permitir todo el tráfico entrante y saliente, y dos etiquetas personalizadas. Este ejemplo muestra cómo llamar al módulo desde un módulo componente de la propia librería:

```terraform
module "public_network_acl" {
  source        = "../../resources/networkACL"
  m_name        = "test"
  m_name_suffix = "public"
  m_vpc_id      = "vpc-xxxxxxx"
  m_ingress_rules = {
    "100" = {
      action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
  }
  m_egress_rules = {
    "100" = {
      action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
  }
  m_tags        = {
    Environment = "develop"
    Project     = "example"
  }
}
```

Para llamar directamente a este módulo desde fuera de la librería sería de la siguiente forma:

```terraform
module "public_network_acl" {
  source          = "git@github.com:MoiVilella/tf_aws_networking_library//modules/resources/networkACL?ref=<tag_version>"
  m_name        = "test"
  m_name_suffix = "public"
  m_vpc_id      = "vpc-xxxxxxx"
  m_ingress_rules = {
    "100" = {
      action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
  }
  m_egress_rules = {
    "100" = {
      action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
  }
  m_tags        = {
    Environment = "develop"
    Project     = "example"
  }
}
```

**Nota:** Como se puede observar en la URL definida en el campo source hay que cambiar el valor `<tag_version>` por el tag de la versión de la librería que se deséa usar.