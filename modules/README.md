# Modules

Este directorio contiene todos los módulos de Terraform organizados en tres niveles: recursos específicos, logicas reutilizables y componentes compuestos. Estos módulos están diseñados para facilitar la gestión de infraestructuras de red en AWS.

## Estructura del Directorio

```
modules
├── resources
│   ├── internetGateway
│   ├── natGateway
│   ├── networkACL
│   ├── routeTable
│   ├── subnet
│   └── vpc
└── logics
│   └── naming
└── components
    └── vpc_standalone
```

### Recursos Específicos

Los módulos en la carpeta `resources` están diseñados para gestionar recursos individuales específicos de AWS. Estos módulos son pequeños, autónomos y reutilizables, proporcionando una base sólida para la construcción de configuraciones más complejas.

#### Módulos Disponibles

- **internetGatewat**: Gestiona la creación de Internet Gateways en una VPC.
- **natGateway**: Gestiona la creación de un NAT Gateway y una Elastic IP en una subred.
- **networkACL**: Gestiona la creación de una Network ACL, sus reglas de entrada/salida y su asociación a subredes en una VPC.
- **routeTable**: Gestiona la creación de una Tabla de Rutas, sus rutas y su asociación a subredes en una VPC.
- **subnet**: Gestiona la creación de subnets en una VPC.
- **vpc**: Gestiona la creación de una VPC.

### Lógicas reutilizables

Los módulos en la carpeta `logics` están diseñados para funcionar como funciones que resuelven lógicas concretas.

#### Módulos Disponibles

- **naming**: Gestiona la adición del tag `Name` a los recursos de forma estandarizada.

### Componentes Compuestos

Los módulos en la carpeta `components` combinan varios recursos de Nivel 1 para crear configuraciones de red más elaboradas y complejas. Estos módulos encapsulan configuraciones completas, como una VPC standalone o una topología en estrella, facilitando su implementación y reutilización.

#### Módulos Disponibles

- **vpc_standalone**: Crea una VPC standalone con todo lo necesario para gestionar subredes públicas y privadas.
