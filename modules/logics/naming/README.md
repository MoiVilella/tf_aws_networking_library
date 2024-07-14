# Naming module

Este módulo es usado para gesstionar la lógica de nombrado de recursos de AWS. Puede ser llamado desde un módulo de componente de la propia librería o desde fuera de ella. Permite generar un nombre a partir de un prefijo, un nombre y un sufijo. Posteriormente usa el nombre generado para añadir un tag `Name` a los tags que haya recibido y devuelve los tags mergeados por el output.

Si en los tags del recurso ya viene un tag `Name` se respetaría el tag definido por el recurso y no sería modificado por este módulo.

## Variables

| Input Variable    | type        | Required | default | Description                                              |
|-------------------|-------------|----------|---------|----------------------------------------------------------|
| m_resource_prefix | string      | yes      |         | Prefix used by Name tag to show the rource type.         |
| m_resource_name   | string      | yes      |         | Name for the resource.                                   |
| m_resource_suffix | string      | no       | null    | Suffix used by the Name tag to show resource extra data. |
| m_tags            | map(string) | yes      |         | Resource tags to be merged with Name tag.                |

## Outputs

Output Variable | Type   | Description
----------------|--------|------------------------------------------------
 vpc_object     | object | The entire resource object of the created VPC.

## Usage

En este ejemplo, se añade un tag `Name` con el "vpc-test" a los tags recibidos y se devolverá por el output los tags mergeados. Este ejemplo muestra cómo llamar al módulo desde un módulo componente de la propia librería:

```terraform
module "naming" {
  source = "../../logics/naming"
  m_resource_prefix = "vpc"
  m_resource_name = "test"
  m_tags = {
    Environment = "develop"
    Project     = "example"
  }
}
```

Para llamar directamente a este módulo desde fuera de la librería sería de la siguiente forma:

```terraform
module "naming" {
  source          = "git@github.com:MoiVilella/tf_aws_networking_library//modules/logics/naming?ref=<tag_version>"
  m_resource_prefix = "vpc"
  m_resource_name = "test"
  m_tags = {
    Environment = "develop"
    Project     = "example"
  }
}
```

**Nota:** Como se puede observar en la URL definida en el campo source hay que cambiar el valor `<tag_version>` por el tag de la versión de la librería que se deséa usar.