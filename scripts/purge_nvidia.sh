#!/usr/bin/env bash

sudo apt --purge remove "*cublas*" "*cufft*" "*curand*" \
 "*cusolver*" "*cusparse*" "*npp*" "*nvjpeg*" "cuda*" "nsight*"

sudo apt --purge remove "*nvidia*"

sudo apt autoremove
