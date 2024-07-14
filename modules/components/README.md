# Módulos de Componente: Configuraciones de Red Compuestas

## Objetivo

Los módulos de componente en nuestra arquitectura de Terraform tienen como objetivo combinar módulos de recursos y módulos de lógicas para crear configuraciones de red más elaboradas y complejas. Estos módulos permiten la creación de topologías completas de red, como una VPC standalone o una topología en estrella, utilizando los recursos específicos definidos en los módulos de recursos.

### Beneficios de los Módulos de Componentes

1. **Abstracción**: Encapsulan configuraciones complejas, haciendo que su uso sea más sencillo y menos propenso a errores.
2. **Consistencia**: Aseguran que las configuraciones de red sigan un patrón uniforme y coherente.
3. **Reutilización**: Permiten reutilizar configuraciones de red completas en diferentes entornos y proyectos.
4. **Facilidad de uso**: Reducen la cantidad de código que los usuarios finales necesitan escribir, enfocándose en las configuraciones de alto nivel.

## Estructura de un Módulo de Componentes

Cada módulo de componente sigue una estructura de ficheros consistente para facilitar su gestión y uso. La estructura básica es la siguiente:

```
/modules
└── components
    └── speciffic_component
        ├── datas.tf
        ├── locals.tf
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── README.md
```

### Descripción de los Ficheros

- **datas.tf**: Contiene las llamadas a AWS para obtener información de recursos ya existentes necesarios por el módulo.
- **locals.tf**: Define las variables locales necesarias para la configuración del componente, generalmente para lógicas exclusivas del módulo.
- **main.tf**: Contiene la definición principal de la configuración de red compuesta, utilizando módulos de recurso.
- **variables.tf**: Define las variables de entrada necesarias para la configuración compuesta.
- **outputs.tf**: Define los outputs proporcionados por el módulo, que pueden ser utilizados por otros módulos o directamente por los usuarios.
- **README.md**: Documentación del módulo, que incluye su propósito, cómo utilizarlo y ejemplos de uso.

Los módulos de Componente son cruciales para construir configuraciones de red reutilizables y consistentes. Al combinar módulos de recurso y de lógica, estos módulos proporcionan una forma sencilla y eficiente de gestionar topologías de red complejas.

Para más detalles sobre cada módulo, consulta la documentación específica en el archivo README.md de cada módulo.