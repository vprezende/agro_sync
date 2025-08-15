# AgroSync: Integrando o futuro do agronegócio

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

## 📜 Visão Geral

Este projeto visa facilitar o planejamento e manejo de sistemas de **Integração Lavoura-Pecuária-Floresta (ILPF)**. A aplicação permite aos usuários desenhar áreas de interesse em um mapa, obter informações detalhadas sobre as características do solo dessas áreas e gerenciar as geometrias desenhadas de forma interativa.

## ✨ Funcionalidades Principais

*   **🗺️ Desenho de Áreas:** Permite aos usuários desenhar múltiplas áreas poligonais diretamente no mapa.
*   **📐 Ordenação de Vértices:** Organiza automaticamente os vértices dos polígonos para formar uma geometria convexa, simplificando o desenho.
*   **🪢 Fechamento de Áreas:** Garante que as áreas desenhadas sejam sempre polígonos fechados para análises precisas.
*   **🔬 Obtenção de Dados de Solo:** Busca informações detalhadas sobre as características do solo, utilizando a API do ISRIC SoilGrids, para o centroide de cada área desenhada.
*   **↩️ Desfazer Ação:** Permite ao usuário reverter a última ação de desenho, oferecendo flexibilidade durante o uso.

## 📸 Screenshots

Confira abaixo algumas capturas de tela que demonstram a interface e as principais funcionalidades da aplicação.

|        Tela Principal do Mapa         |       Análise Detalhada do Solo        |
|:-------------------------------------:|:--------------------------------------:|
| ![Tela Principal](URL_DA_IMAGEM_AQUI) | ![Análise do Solo](URL_DA_IMAGEM_AQUI) |

## 🚀 Como Usar

### Pré-requisitos

*   [Flutter](https://flutter.dev/docs/get-started/install) instalado
*   Um editor de código (ex: [VS Code](https://code.visualstudio.com/), [Android Studio](https://developer.android.com/studio))

### Instalação e Execução

1.  Clone o repositório:
    ```bash
    git clone https://github.com/vprezende/agro_sync.git
    ```
2.  Navegue até o diretório do projeto:
    ```bash
    cd agro_sync
    ```
3.  Instale as dependências:
    ```bash
    flutter pub get
    ```
4.  Execute a aplicação:
    ```bash
    flutter run
    ```

## 🛠️ Tecnologias Utilizadas

*   **Flutter:** Framework para desenvolvimento de aplicações multiplataforma.
*   **Dart:** Linguagem de programação utilizada pelo Flutter.
*   **Google Maps Flutter:** Plugin para integração com o Google Maps.
*   **ISRIC SoilGrids API:** API para obtenção de dados de solo.

## 🤝 Como Contribuir

Contribuições são bem-vindas! Se você deseja contribuir com o projeto, siga os passos abaixo:

1.  Faça um "fork" do projeto.
2.  Crie uma nova "branch" para sua funcionalidade (`git checkout -b feature/nova-funcionalidade`).
3.  Faça o "commit" de suas alterações (`git commit -m 'Adiciona nova funcionalidade'`).
4.  Faça o "push" para a "branch" (`git push origin feature/nova-funcionalidade`).
5.  Abra um "Pull Request".

## 📄 Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
