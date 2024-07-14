# VPC module

Este módulo es usado para crear VPCs en una región de AWS. Puede ser llamado desde un módulo de componente de la propia librería o desde fuera de ella. Permite opciones configurables para soporte de DNS y hostnames DNS. Además, permite la asignación de etiquetas personalizadas.

La composición de la etiqueta `Name` se lleva a cabo mediante el uso del módulo [naming](../../logics/naming/).

## Variables

| Input Variable  | type        | Required | default | Description                                                                  |
|-----------------|-------------|----------|---------|------------------------------------------------------------------------------|
| m_name          | string      | yes      |         | Base name used by the VPC.                                                   |
| m_vpc_cidr      | string      | yes      |         | IP CIDR block used by the VPC. The CIDR block must contain the mask.         |
| m_dns_support   | bool        | no       | true    | A boolean flag to enable/disable DNS support in the VPC. The DNS resolution attribute determines whether DNS resolution through the Amazon DNS server is supported for the VPC.|
| m_dns_hostnames | bool        | no       | false   | A boolean flag to enable/disable DNS hostnames in the VPC. The DNS hostnames attribute determines whether instances launched in the VPC receive public DNS hostnames that correspond to their public IP addresses. |   
| m_tags          | map(string) | no       | {}      | Map with tags names and values.                                              |

## Outputs

Output Variable | Type   | Description
----------------|--------|------------------------------------------------
 vpc_object     | object | The entire resource object of the created VPC.

## Usage

En este ejemplo, se crea una VPC con el nombre "vpc-test", un bloque CIDR de "10.0.0.0/16", el soporte DNS habilitado, los nombres de host DNS deshabilitados y dos etiquetas personalizadas. Este ejemplo muestra cómo llamar al módulo desde un módulo componente de la propia librería:

```terraform
module "vpc" {
  source          = "../../resources/vpc"
  m_name          = "test"
  m_vpc_cidr      = "10.0.0.0/16"
  m_dns_support   = true
  m_dns_hostnames = false
  m_tags = {
    Environment = "develop"
    Project     = "example"
  }
}
```

Para llamar directamente a este módulo desde fuera de la librería sería de la siguiente forma:

```terraform
module "vpc" {
  source          = "git@github.com:MoiVilella/tf_aws_networking_library//modules/resources/vpc?ref=<tag_version>"
  m_name          = "test"
  m_vpc_cidr      = "10.0.0.0/16"
  m_dns_support   = true
  m_dns_hostnames = false
  m_tags = {
    Environment = "develop"
    Project     = "example"
  }
}
```

**Nota:** Como se puede observar en la URL definida en el campo source hay que cambiar el valor `<tag_version>` por el tag de la versión de la librería que se deséa usar.