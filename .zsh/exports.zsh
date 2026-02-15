export LS_COLORS="${LS_COLORS}:di=36"

# CUDA
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# Neovim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
