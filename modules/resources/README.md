# Resource modules: Gestión de Recursos Específicos

## Objetivo

Los módulos de tipo recurso en nuestra arquitectura de Terraform tienen como objetivo gestionar recursos específicos y bien definidos dentro de una VPC. Estos módulos se diseñan para ser pequeños, autónomos y reutilizables, proporcionando una base sólida para construir configuraciones de red más complejas en los niveles superiores.

### Beneficios de los Módulos de recursos

1. **Reusabilidad**: Los módulos de recursos son altamente reutilizables y pueden ser integrados en múltiples configuraciones de red.
2. **Mantenibilidad**: Al ser módulos pequeños y específicos, son más fáciles de mantener y actualizar.
3. **Testabilidad**: Es más sencillo realizar pruebas unitarias en módulos pequeños, lo que ayuda a garantizar su correcto funcionamiento.
4. **Simplicidad**: Fomentan una separación de preocupaciones, manteniendo el código claro y comprensible.

## Estructura de un Módulo de recurso

Cada módulo de recurso sigue una estructura de ficheros consistente para facilitar su gestión y uso. La estructura básica es la siguiente:

```
/modules
└──resources
    └── speciffic_resource
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        ├── locals.tf
        └── README.md
```

### Descripción de los Ficheros

- **main.tf**: Contiene la definición principal del recurso gestionado por el módulo.
- **variables.tf**: Define las variables de entrada necesarias para la configuración del recurso.
- **outputs.tf**: Define los outputs proporcionados por el módulo, que pueden ser utilizados por otros módulos.
- **locals.tf**: Define las variables locales necesarias para la configuración del recurso, generalmente para lógicas exclusivas del módulo.
- **README.md**: Documentación del módulo, que incluye su propósito, cómo utilizarlo y ejemplos de uso.

Los módulos de recurso son esenciales para mantener una arquitectura de Terraform modular y eficiente. Al gestionar recursos específicos, estos módulos proporcionan una base sólida para la construcción de infraestructuras más complejas en niveles superiores.

Para más detalles sobre cada módulo, consulta la documentación específica en el archivo README.md de cada módulo.
