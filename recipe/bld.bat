mkdir build
cd build

if "%gpl_ok%" == "True" (
    set extra_opts="-DMIT=ON "
) else (
set extra_opts=""
)

# * ENABLE_TESTING: Testing requires lit which is not packaged yet:
#   https://github.com/conda-forge/staged-recipes/issues/4630
cmake ^
  -G "%CMAKE_GENERATOR%" ^
  "-DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%" ^
  -DENABLE_PYTHON_INTERFACE=OFF ^
  -DENABLE_TESTING=OFF ^
  -DONLY_SIMPLE=ON ^
  -DCMAKE_BUILD_TYPE=Release ^
  %extra_opts% ^
  ..
if errorlevel 1 exit /b 1

cmake --build . --config Release
if errorlevel 1 exit /b 1
