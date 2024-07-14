# Logic modules: Gestión de lógicas Específicas

## Objetivo

Los módulos de tipo lógica en nuestra arquitectura de Terraform tienen como objetivo gestionar logicas específicas y reutilizables como si fuesen funciones, recibiendo unos valores de entrada para generar una salida que sea de valor para módulos de recurso o de componente. Estos módulos se diseñan para ser pequeños, autónomos y reutilizables, proporcionando una base sólida para construir configuraciones de red más complejas en los niveles superiores.

### Beneficios de los Módulos de lógica

1. **Reusabilidad**: Los módulos de lógica son altamente reutilizables y pueden ser integrados en múltiples configuraciones de red para dar solución a problemas concretos.
2. **Mantenibilidad**: Al ser módulos pequeños y específicos, son más fáciles de mantener y actualizar.
3. **Testabilidad**: Es más sencillo realizar pruebas unitarias en módulos pequeños, lo que ayuda a garantizar su correcto funcionamiento.
4. **Simplicidad**: Fomentan una separación de preocupaciones, manteniendo el código claro y comprensible.

## Estructura de un Módulo de recurso

Cada módulo de recurso sigue una estructura de ficheros consistente para facilitar su gestión y uso. La estructura básica es la siguiente:

```
/modules
└──logics
    └── speciffic_logic
        ├── variables.tf
        ├── outputs.tf
        ├── locals.tf
        └── README.md
```

### Descripción de los Ficheros

- **variables.tf**: Define las variables de entrada necesarias para la ejecución de la función.
- **outputs.tf**: Define los outputs proporcionados por el módulo, que pueden ser utilizados por otros módulos.
- **locals.tf**: Define las variables locales que necesarias para la transformación de las variables de entrada y generación de los valores de salida.
- **README.md**: Documentación del módulo, que incluye su propósito, cómo utilizarlo y ejemplos de uso.