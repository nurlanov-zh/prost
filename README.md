# prost
This is a modified code from [prost](https://github.com/tum-vision/prost) library solving large-scale problems with **pro**ximal **st**ructure.

## Tested on

    Ubuntu 18.04
    Nvidia GeForce GTX 1050, Driver Version: 440.100
    CUDA 10.2
    Matlab R2015-b
    cmake 3.10.2
    g++ 7.5.0
    
### Compile

    cd prost
    mkdir build
    cd build
    cmake ..
    make -j 4
    
### Usage
Start matlab via following command:

    LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libstdc++.so.6" matlab
    
Add the folder `prost/matlab` to your MATLAB path, e.g. by writing
```
addpath('path/to/prost/matlab')
```
from within MATLAB.