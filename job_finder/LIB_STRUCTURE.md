# Estrutura de Diretórios - Job Finder

## Visão Geral

A arquitetura do projeto segue o padrão **Clean Architecture** com dois pilares principais: **Core** e **Features**.

```
lib/
├── core/                      # Componentes reutilizáveis e fundamentais
│   ├── constants/             # Constantes globais da aplicação
│   ├── theme/                 # Temas, cores e estilos de texto
│   ├── utils/                 # Utilitários gerais (validadores, loggers)
│   ├── widgets/               # Widgets reutilizáveis
│   ├── extensions/            # Extensões de classes
│   ├── config/                # Configurações da aplicação
│   └── services/              # Serviços globais (API, Storage)
│
├── features/                  # Funcionalidades específicas
│   ├── auth/                  # Feature de autenticação
│   │   ├── presentation/      # UI e lógica de apresentação
│   │   │   ├── pages/         # Páginas
│   │   │   ├── widgets/       # Widgets específicos da feature
│   │   │   └── controller/    # Controllers/StateManagement
│   │   ├── data/              # Acesso a dados
│   │   │   ├── models/        # Modelos de dados
│   │   │   ├── repositories/  # Implementação de repositórios
│   │   │   └── providers/     # Providers de dados
│   │   └── domain/            # Lógica de negócio
│   │       └── entities/      # Entidades
│   │
│   ├── home/                  # Feature de home
│   │   ├── presentation/
│   │   ├── data/
│   │   └── domain/
│   │
│   └── job_details/           # Feature de detalhes do emprego
│       ├── presentation/
│       ├── data/
│       └── domain/
│
└── main.dart                  # Ponto de entrada da aplicação
```

## Descrição das Camadas

### 1. **CORE** (Núcleo)

Contém componentes reutilizáveis e fundamentais para toda a aplicação.

#### **constants/** 
- Constantes globais: URLs, timeouts, strings
- `app_constants.dart`

#### **theme/**
- `app_colors.dart` - Paleta de cores
- `app_theme.dart` - Temas (light/dark)
- `text_styles.dart` - Estilos de texto

#### **utils/**
- `validators.dart` - Validações (email, senha, etc)
- `logger.dart` - Sistema de logging

#### **widgets/**
- Componentes reutilizáveis: `AppButton`, `AppTextField`, etc
- `app_button.dart`

#### **extensions/**
- Extensões de classes padrão
- `context_extensions.dart` - Extensões de BuildContext

#### **config/**
- Configurações da aplicação
- `app_config.dart`

#### **services/**
- Serviços globais: API, Local Storage, Push Notifications
- `api_service.dart`

---

### 2. **FEATURES** (Funcionalidades)

Cada feature é organizada em três camadas: **Presentation**, **Data**, **Domain**.

#### **Estrutura de cada Feature**

```
feature_name/
├── presentation/              # Camada de apresentação
│   ├── pages/                 # Páginas/Telas
│   ├── widgets/               # Widgets específicos
│   └── controller/            # Controllers ou Providers
│
├── data/                      # Camada de dados
│   ├── models/                # Modelos (entidades serializáveis)
│   ├── repositories/          # Implementação de repositórios
│   └── providers/             # Providers de dados (se usar)
│
└── domain/                    # Camada de domínio
    └── entities/              # Entidades (objetos puros)
```

#### **Exemplo: Feature Auth**

- **Domain/Entities**: `UserEntity` - Objeto puro sem serialização
- **Data/Models**: `UserModel` - Herda de `UserEntity`, com `toJson()` e `fromJson()`
- **Data/Repositories**: Interface e implementação de autenticação
- **Presentation/Pages**: `LoginPage`, `RegisterPage`
- **Presentation/Controller**: `AuthController` - Gerencia estado

---

## Como Adicionar uma Nova Feature

1. **Criar a estrutura**:
   ```
   lib/features/[feature_name]/
   ├── presentation/
   │   ├── pages/
   │   ├── widgets/
   │   └── controller/
   ├── data/
   │   ├── models/
   │   ├── repositories/
   │   └── providers/
   └── domain/
       └── entities/
   ```

2. **Criar Domain Layer**:
   - Definir `entities/` com classes puras

3. **Criar Data Layer**:
   - Criar `models/` estendendo entities
   - Implementar `repositories/` com lógica de acesso a dados

4. **Criar Presentation Layer**:
   - Criar `controller/` para gerenciar estado
   - Criar `pages/` para as telas
   - Criar `widgets/` para componentes reutilizáveis

---

## Exemplo de Fluxo de Dados

```
User Input (Page)
    ↓
Controller (Apresentation)
    ↓
Repository (Data)
    ↓
ApiService (Core/Services)
    ↓
Backend API
    ↓
Model (Data)
    ↓
Entity (Domain)
    ↓
Controller atualiza estado
    ↓
Widget rebuilda com novos dados
```

---

## Boas Práticas

✅ **Fazer**:
- Manter `core/` focado em utilitários reutilizáveis
- Isolar cada feature em seu próprio módulo
- Seguir a separação de camadas (Domain → Data → Presentation)
- Usar injeção de dependência

❌ **Evitar**:
- Imports circulares entre features
- Lógica de negócio nas pages
- Acessar diretamente a API nos controllers
- Misturar camadas (data layer chamando presentation)

---

## Próximas Etapas

1. Implementar injeção de dependência (GetIt, Riverpod, Provider)
2. Adicionar tratamento de erros robusto
3. Implementar caching local (Hive, SQLite)
4. Adicionar testes unitários e de integração
5. Configurar CI/CD
