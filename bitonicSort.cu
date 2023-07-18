
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include<stdlib.h>
#include <stdio.h>
#include<math.h>

__global__ void BitonicSortParallel(int *inputData,int step,int stage, int N,int choice){
    
    // calculate the index of the thread
    int index = blockIdx.x * blockDim.x + threadIdx.x;


    if (index < N) {

        // the stride of a thread in a stage
        int stride = (int)pow(2, step - stage);
        // the sequence length in a stage 
        int seqLength = ((int)pow(2, step - stage + 1));
        
        // if the thread is active in a stage
        if (index % seqLength  < stride ) {
        
            // to cheack whether the thread should sort ascendingly or descendingly
            if (index / ((int)pow(2, step)) % 2 == choice) {
                if (inputData[index] > inputData[index + stride]) {
                    //swap
                    int tmp = inputData[index];
                    inputData[index] = inputData[index + stride];
                    inputData[index + stride] = tmp;
                }
            }
            else {
                if (inputData[index] < inputData[index + stride]) {
                    //swap
                    int tmp = inputData[index];
                    inputData[index] = inputData[index + stride];
                    inputData[index + stride] = tmp;
                }
            }
        }
    }
}


__global__ void kernal(int N, int M) {
    int i = blockIdx.y;
    int j = blockIdx.x;
    printf("i:%d j:%d\n",i, j);
}

int main(void) {
    int* a = NULL;
    cudaMalloc(&a,8);
    a[0] = 5;
    a[1] = 5;
    a[2] = 5;

    printf("%d", a[0,0]);

}