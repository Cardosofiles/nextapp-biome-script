# 🚀 Script de Criar uma aplicação com NextJS, Shadcn UI e Biome Automatizado no WSL

Este script simplifica o fluxo de trabalho da criação de uma aplicação Next, com Shadcn UI
iniciando e criando um repositório com o Git e Github.

- What is your project named? my-app (Pergunta no início do script)
- Would you like to use TypeScript? No / Yes (Yes para TypeScript)
- Would you like to use ESLint? No / Yes (No para ESLint)
- Would you like to use Tailwind CSS? No / Yes (Yes para TailwindCSS)
- Would you like your code inside a `src/` directory? No / Yes (Yes para src)
- Would you like to use App Router? (recommended) No / Yes (Yes para App Router)
- Would you like to use Turbopack for `next dev`? No / Yes (Yes para Turbopack)
- Would you like to customize the import alias (`@/*` by default)? No / Yes (Yes para alias)
- What import alias would you like configured? @/\* (No para configured)

---

## 📁 Estrutura

- Script: `create-next.sh`
- Local: `~/create-next-app.sh`

---

## 📜 Conteúdo do Script

```bash
#!/bin/bash

clear
echo "🚀 Criador de projetos Next.js avançado com pnpm + Tailwind + Biome + Shadcn + GitHub"

# 🧠 Pergunta o nome do projeto
read -p "📦 Qual o nome do projeto? " project_name

if [ -z "$project_name" ]; then
  echo "❌ Nome do projeto não pode estar vazio."
  exit 1
fi

# 🚧 Cria o projeto com as opções desejadas
pnpm create next-app@latest "$project_name" \
  --ts \
  --tailwind \
  --app \
  --src-dir \
  --no-eslint \
  --import-alias '@/*' \
  --turbopack \
  --no

cd "$project_name" || exit 1

echo "✅ Projeto criado com sucesso!"

# 💿 Instala dependências do Shadcn UI
echo "📦 Instalando dependências do Shadcn UI..."
pnpm add @shadcn/ui clsx tailwind-variants

# ⚙️ Inicializa Shadcn UI
echo "⚙️ Inicializando Shadcn UI..."
echo "🎨 Ao iniciar, selecione a cor base desejada usando as setas do teclado (⬆️⬇️) e pressione ENTER:"
echo "    → Neutral"
echo "    → Gray"
echo "    → Zinc"
echo "    → Stone"
echo "    → Slate"
pnpm dlx shadcn@latest init

# 🧹 Instala o Biome e cria configuração
echo "📏 Instalando Biome (substituto do ESLint/Prettier)..."
pnpm add -D @biomejs/biome
cat > biome.json <<EOF
{
  "extends": [],
  "linter": {
    "enabled": true
  },
  "formatter": {
    "enabled": true,
    "indentStyle": "space",
    "indentWidth": 2,
    "lineEnding": "lf",
    "lineWidth": 100,
    "quoteStyle": "double"
  }
}
EOF

# 🧬 Inicializa Git + GitHub
read -p "🔗 Deseja criar repositório Git local? (y/n): " git_init
if [[ "$git_init" == "y" ]]; then
  git init
  git add .
  git commit -m "🧱 initial commit"

  read -p "🌐 Deseja criar um repositório no GitHub e fazer push? (y/n): " gh_push
  if [[ "$gh_push" == "y" ]]; then
    read -p "🔐 Qual o nome do repositório no GitHub (ou ENTER para '$project_name')? " repo_name
    repo_name=${repo_name:-$project_name}

    gh repo create "$repo_name" --public --source=. --remote=origin --push
    echo "✅ Repositório enviado para o GitHub!"
  fi
fi

# ✅ Finalização
echo -e "\n🎉 Projeto '$project_name' criado e pronto para desenvolvimento!"
echo -e "\n👉 Rode com: \033[1mpnpm dev\033[0m"
```

---

## ✅ Como Instalar e Usar

### 1. 📥 Criar o script

```bash
nano ~/create-next-app.sh
```

Cole o conteúdo acima e salve (`Ctrl+O`, `Enter`, `Ctrl+X`).

---

### 2. 🔓 Dar permissão de execução

```bash
chmod +x ~/create-next-app.sh
```

---

### 3. ⚙️ Tornar o script global

Edite o arquivo `.zshrc` ou `.bashrc`:

```bash
nano ~/.zshrc
```

Adicione esta linha ao final:

```bash
alias create-next="~/create-next-app.sh"
```

Salve e recarregue o terminal:

```bash
source ~/.zshrc
```

---

### 4. 🚀 Usar o comando

Navegue até o diretório do seu projeto e rode:

```bash
create-next
```

---

## 🧠 Dica

Você pode personalizar este script para incluir validações, log de histórico, commits convencionais, entre outros.

---

## 📌 Requisitos

- Git instalado
- Node instalado >= 18
- Pnpm instalado globalmente
- Terminal WSL (Ubuntu)
- Github CLI configurado (opcional, para criar repositório no GitHub)

---

## 🛠 Exemplo de uso

```bash
$ create-next
📦 Aguarde a instalação, siga o passo a passo do script no terminal 🚀
```

## Configuração do BiomeJS

- Atualize o arquivo biome.json na raiz do projeto

```bash
{
  "$schema": "./node_modules/@biomejs/biome/configuration_schema.json",
  "organizeImports": {
    "enabled": true
  },
  "formatter": {
    "indentStyle": "space",
    "indentWidth": 2,
    "lineWidth": 80
  },
  "javascript": {
    "formatter": {
      "arrowParentheses": "asNeeded",
      "jsxQuoteStyle": "double",
      "quoteStyle": "single",
      "semicolons": "asNeeded",
      "trailingCommas": "es5"
    }
  },
  "linter": {
    "enabled": true,
    "rules": {
      "recommended": true,
      "a11y": {
        "noSvgWithoutTitle": "off"
      },
      "suspicious": {
        "noArrayIndexKey": "info"
      }
    }
  },
  "files": {
    "ignore": [
      "node_modules"
    ]
  }
}
```

- Abra o workspace-settings-vscode

```bash
{
  "[javascript]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[typescript]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[typescriptreact]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "editor.codeActionsOnSave": {
    "source.organizeImports.biome": "explicit"
  },
  "editor.formatOnSave": true
}
```
