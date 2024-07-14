# Route Table module

Este módulo es usado para crear tablas de rutas en VPCs de AWS y asociarlarlas a subredes. Puede ser llamado desde un módulo de componente de la propia librería o desde fuera de ella. Permite gestionar las rutas asociadas a la tabla de rutas mediante un bloque dinámico a partir de un mapa de objetos. Además, permite la asignación de etiquetas personalizadas.

La composición de la etiqueta `Name` se lleva a cabo mediante el uso del módulo [naming](../../logics/naming/).

## Variables

| Input Variable  | type         | Required | default | Description                                                                       |
|-----------------|--------------|----------|---------|-----------------------------------------------------------------------------------|
| m_name          | string       | yes      |         | Base name used by the route table                                                 |
| m_name_suffix   | string       | no       | null    | Suffix for the the route table name. Useful to add extra information at the name. |
| m_vpc_id        | string       | yes      |         | The VPC ID where the route table will be created.                                 |
| m_subnets_ids   | list(string) | no       | []      | List of subnet IDs to attatch to this route table.                                |
| [m_routes](#m_routes-objects) | map(object) | no | {} | Map with routes to add into the route table.                                    |
| m_tags          | map(string)  | no       | {}      | Map with tags names and values.                                                   |

### m_routes objects

| keys                      | type   | Required | default | Description                                                                   |
|---------------------------|--------|----------|---------|-------------------------------------------------------------------------------|
| cidr_block                | string | yes      |         | CIDR Block used by the route to send traffic to. Must contain IP and mask.    |
| gateway_id                | string | no       |         | AWS Internet Gateway ID to route traffic through.                             |
| nat_gateway_id            | string | no       |         | AWS NAT Gateway ID to route traffic through.                                  |
| network_interface_id      | string | no       |         | AWS Network Interface ID to route traffic through.                            |
| transit_gateway_id        | string | no       |         | AWS Transit Gateway ID to route traffic through.                              |
| vpc_endpoint_id           | string | no       |         | AWS VPC Endpoint ID to route traffic through.                                 |
| vpc_peering_connection_id | string | no       |         | AWS Peering Connection ID to route traffic through.                           |

## Outputs

Output Variable | Type   | Description
----------------|--------|--------------------------------------------------------
 route_table    | object | The entire resource object of the created Route Table.

## Usage

En este ejemplo, se crea una Tabla de rutas con el nombre "rt-test-public", con una ruta configurada para enrutar el tráfico a internet a través de un AWS Internet Gateway y dos etiquetas personalizadas. Este ejemplo muestra cómo llamar al módulo desde un módulo componente de la propia librería:

```terraform
module "route_table" {
  source        = "../../resources/routeTable"
  m_name        = "test"
  m_name_suffix = "public"
  m_vpc_id      = "vpc-xxxxxxx"
  m_routes      = {
    internet_route = {
      cidr_block = "0.0.0.0/0", 
      gateway_id = "igw-xxxxxxx"
    }
  }
  m_tags = {
    Environment = "develop"
    Project     = "example"
  }
}
```

Para llamar directamente a este módulo desde fuera de la librería sería de la siguiente forma:

```terraform
module "route_table" {
  source          = "git@github.com:MoiVilella/tf_aws_networking_library//modules/resources/routeTable?ref=<tag_version>"
  m_name        = "test"
  m_name_suffix = "public"
  m_vpc_id      = "vpc-xxxxxxx"
  m_routes      = {
    internet_route = {
      cidr_block = "0.0.0.0/0", 
      gateway_id = "igw-xxxxxxx"
    }
  }
  m_tags = {
    Environment = "develop"
    Project     = "example"
  }
}
```

**Nota:** Como se puede observar en la URL definida en el campo source hay que cambiar el valor `<tag_version>` por el tag de la versión de la librería que se deséa usar.