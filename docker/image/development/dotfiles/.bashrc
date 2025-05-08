#!/bin/bash

# Install VSCode extensions from the .vscode/extensions.json file
if [ "$(pwd)" = $PROJECT_DIR ]; then
  if [ -f ".vscode/extensions.json" ]; then
    extensions=$(grep -o '"[^"]*"' .vscode/extensions.json | grep -v "recommendations\|unwantedRecommendations" | tr -d '"')

    for ext in $extensions; do
      code --install-extension "$ext" &>/dev/null
    done
  fi
fi