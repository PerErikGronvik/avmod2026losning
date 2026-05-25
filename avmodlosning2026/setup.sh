#!/bin/bash
# Look in README.md for setup instructions before running this script.

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    echo -e "\033[0;31muv is not installed!\033[0m"
    echo -e "\033[0;33muv is required to manage Python dependencies.\033[0m"
    echo ""
    echo -e "\033[0;36mInstall uv by running:\033[0m"
    echo -e "  curl -LsSf https://astral.sh/uv/install.sh | sh"
    echo ""
    read -p "Install uv now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "\033[0;36mInstalling uv...\033[0m"
        curl -LsSf https://astral.sh/uv/install.sh | sh
        echo -e "\033[0;32mPlease restart your terminal and run this script again.\033[0m"
        exit 0
    else
        echo -e "\033[0;33mInstallation cancelled. Please install uv manually and try again.\033[0m"
        exit 1
    fi
fi

folderName=$(basename "$PWD")
kernelName="$folderName-venv"

echo -e "\033[0;36mSetting up environment in $folderName...\033[0m"

# Use uv to sync environment
echo -e "\033[0;36mRunning uv sync...\033[0m"
uv sync

# Register as Jupyter kernel with unique name based on folder
echo -e "\033[0;36mRegistering Jupyter kernel '$kernelName'...\033[0m"
./.venv/bin/python -m ipykernel install --user --name="$kernelName" --display-name="Python 3 ($folderName)"

# Refresh Jupyter kernel list
echo -e "\033[0;36mRefreshing Jupyter kernel list...\033[0m"
./.venv/bin/jupyter kernelspec list

echo ""
echo -e "\033[0;32mDone! Now in VS Code:\033[0m"
echo -e "\033[0;33m1. Reload VS Code window (Ctrl+Shift+P -> Reload Window)\033[0m"
echo -e "2. Open the notebook"
echo -e "3. Click Select Kernel (top right)"
echo -e "4. Choose Python 3 ($folderName)"
echo ""
echo -e "\033[0;90mKernel path: $PWD/.venv/bin/python\033[0m"
