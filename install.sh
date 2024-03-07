#!/usr/bin/env bash
set -e
prefix="$HOME/opt"
[[ -d "$prefix" ]] || mkdir -p "$prefix"
[[ -f "./bash.sums" ]] || cat <<-EOF > "./bash.sums"
    c8e31bdc59b69aaffc5b36509905ba3e5cbb12747091d27b4b977f078560d5b8  bash-5.2.21.tar.gz
    78b5230a49594ec30811e72dcd0f56d1089710ec7828621022d08507aa57e470  bash52-022
    af905502e2106c8510ba2085aa2b56e64830fc0fdf6ee67ebb459ac11696dcd3  bash52-023
    971534490117eb05d97d7fd81f5f9d8daf927b4d581231844ffae485651b02c3  bash52-024
    5138f487e7cf71a6323dc81d22419906f1535b89835cc2ff68847e1a35613075  bash52-025
    96ee1f549aa0b530521e36bdc0ba7661602cfaee409f7023cac744dd42852eac  bash52-026
EOF
[[ -f bash-5.2.21.tar.gz ]] || curl -L --fail https://ftp.gnu.org/gnu/bash/bash-5.2.21.tar.gz -o bash-5.2.21.tar.gz
[[ -f bash52-022 ]] || curl -L --fail https://ftp.gnu.org/gnu/bash/bash-5.2-patches/bash52-022 -o bash52-022
[[ -f bash52-023 ]] || curl -L --fail https://ftp.gnu.org/gnu/bash/bash-5.2-patches/bash52-023 -o bash52-023
[[ -f bash52-024 ]] || curl -L --fail https://ftp.gnu.org/gnu/bash/bash-5.2-patches/bash52-024 -o bash52-024
[[ -f bash52-025 ]] || curl -L --fail https://ftp.gnu.org/gnu/bash/bash-5.2-patches/bash52-025 -o bash52-025
[[ -f bash52-026 ]] || curl -L --fail https://ftp.gnu.org/gnu/bash/bash-5.2-patches/bash52-026 -o bash52-026
/usr/bin/shasum -a 256 -c bash.sums
tar -xvzf ./bash-5.2.21.tar.gz
cd bash-5.2.21/
patch -g 0 -f -p0 -i ../bash52-022
patch -g 0 -f -p0 -i ../bash52-023
patch -g 0 -f -p0 -i ../bash52-024
patch -g 0 -f -p0 -i ../bash52-025
patch -g 0 -f -p0 -i ../bash52-026
./configure --prefix="$prefix"
make
make check
make install
cd ..
rm -rf ./bash-5.2.21
