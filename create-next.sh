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
