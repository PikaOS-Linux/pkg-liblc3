# Clone Upstream
git clone https://github.com/google/liblc3 -b v1.0.4
cp -rvf ./debian ./liblc3/
cd ./liblc3

for i in ../patches/* ; do echo "Applying Patch: $i" && patch -Np1 -i $i || echo "Applying Patch $i Failed!"; done

LOGNAME=root dh_make --createorig -y -l -p liblc3_1.0.4

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
