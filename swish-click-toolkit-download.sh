#!/usr/bin/env bash
# swish-click-toolkit-download.sh
# Quick-start script to fetch Swish & Click’s recommended automation repos
# and bundle them into a single ZIP. Run from any machine with git + zip installed.

set -euo pipefail

WORKDIR="swish-click-toolkit"
echo "🚀 Creating $WORKDIR ..."
rm -rf "$WORKDIR"
mkdir "$WORKDIR"
cd "$WORKDIR"

declare -A REPOS=(
  ["n8n_templates"]="https://github.com/enescingoz/awesome-n8n-templates.git"
  ["n8n_custom_nodes"]="https://github.com/synzen/n8n-nodes.git"
  ["apify_actor_templates"]="https://github.com/apify/actor-templates.git"
  ["supabase_examples"]="https://github.com/supabase/supabase.git"
  ["prompt_engineering_guide"]="https://github.com/dair-ai/Prompt-Engineering-Guide.git"
  ["openai_cookbook"]="https://github.com/openai/openai-cookbook.git"
  ["n8n_docs"]="https://github.com/n8n-io/n8n-docs.git"
  ["oauth2_client_examples"]="https://github.com/n8n-io/js-client-oauth2-extended.git"
)

for DIR in "${!REPOS[@]}"; do
  echo "⬇️  Cloning ${REPOS[$DIR]} ..."
  git clone --depth 1 "${REPOS[$DIR]}" "$DIR"
  # Remove git metadata to shrink final ZIP
  rm -rf "$DIR/.git"
done

cd ..
echo "📦 Zipping $WORKDIR ..."
zip -r swish-click-toolkit.zip "$WORKDIR"

echo "✅ Done! Your package is at $(pwd)/swish-click-toolkit.zip"
