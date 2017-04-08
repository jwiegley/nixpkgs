#!/usr/bin/env nix-shell
#! nix-shell -i bash -p google-cloud-sdk

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NIXPKGS_ROOT="$DIR/../../../../"
BUCKET_NAME="${BUCKET_NAME:-nixos-images}"
export NIX_PATH=nixpkgs="$NIXPKGS_ROOT"
export NIXOS_CONFIG="$NIXPKGS_ROOT/nixos/modules/virtualisation/google-compute-image.nix"
TIMESTAMP="$(date +%Y%m%d%H%M)"
export TIMESTAMP

nix-build '<nixpkgs/nixos>' \
   -A config.system.build.googleComputeImage \
   --argstr system x86_64-linux \
   -o gce \
   --option extra-binary-caches https://hydra.nixos.org \
   -j 10

img_path=$(echo gce/*.tar.gz)
img_name=$(basename "$img_path")
img_id=$(echo "$img_name" | sed 's|.raw.tar.gz$||;s|\.|-|g;s|_|-|g')
if ! gsutil ls "gs://${BUCKET_NAME}/$img_name"; then
  gsutil cp "$img_path" "gs://${BUCKET_NAME}/$img_name"
fi
gcloud compute images create "$img_id" --source-uri "gs://${BUCKET_NAME}/$img_name"
