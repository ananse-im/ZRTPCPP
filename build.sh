ARCHs=("armeabi-v7a" "armeabi" "armeabi-v7a with NEON" "armeabi-v7a with VFPV3" "armeabi-v6 with VFP" "arm64-v8a" "mips" "mips64" "x86" "x86_64")
LIPO_ARGS=""
for i in "${ARCHs[@]}"
do
   echo "$i"
   # or do whatever with individual element of the array
  rm -rf "build-${i}"
  mkdir "build-${i}"
  cd "build-${i}"
  cmake -DANDROID_NDK=$NDK_HOME -DANDROID=true -DCORE_LIB=true -DANDROID_ABI="${i}" -DCMAKE_TOOLCHAIN_FILE=../toolchains/android.toolchain.cmake ../
  make
  cd ../
  LIPO_ARGS="${LIPO_ARGS} build-${i}/clients/no_client/libzrtpcppcore.so"
done

rm -rf build
mkdir build
lipo -create ${LIPO_ARGS} -o libzrtpcppcore.so


# for i in "${ARCHs[@]}"
# do
#    # or do whatever with individual element of the array
#   rm -rf "build-${i}"
# done
# 
# echo "DONE"