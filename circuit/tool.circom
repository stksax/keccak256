pragma circom 2.1.5;

include "../../../node_modules/circomlib/circuits/gates.circom";
include "../../../node_modules/circomlib/circuits/sha256/xor3.circom";
include "../../../node_modules/circomlib/circuits/sha256/shift.circom"; 

template Xor5(n) {
    signal input a[n];
    signal input b[n];
    signal input c[n];
    signal input d[n];
    signal input e[n];
    signal output out[n];
    // var i;
    
    // component xor3 = Xor3(n);
    // for (i=0; i<n; i++) {
    //     xor3.a[i] <== a[i];
    //     xor3.b[i] <== b[i];
    //     xor3.c[i] <== c[i];
    // }
    // component xor4 = XorArray(n);
    // for (i=0; i<n; i++) {
    //     xor4.a[i] <== xor3.out[i];
    //     xor4.b[i] <== d[i];
    // }
    // component xor5 = XorArray(n);
    // for (i=0; i<n; i++) {
    //     xor5.a[i] <== xor4.out[i];
    //     xor5.b[i] <== e[i];
    // }
    // for (i=0; i<n; i++) {
    //     out[i] <== xor5.out[i];
    // }
    out <== XorArray(n)(XorArray(n)(Xor3(n)(a,b,c),d),e);
}

template XorArray(n) {
    signal input a[n];
    signal input b[n];
    signal output out[n];

    for (var i=0; i<n; i++) {
        out[i] <== XOR()(a[i],b[i]);
    }
}

template XorArraySingle(n) {
    signal input a[n];
    signal output out[n];
    var i;

    component aux[n];
    for (i=0; i<n; i++) {
        aux[i] = XOR();
        aux[i].a <== a[i];
        aux[i].b <== 1;
    }
    for (i=0; i<n; i++) {
        out[i] <== aux[i].out;
    }
}

template OrArray(n) {
    signal input a[n];
    signal input b[n];
    signal output out[n];
    var i;

    component aux[n];
    for (i=0; i<n; i++) {
        aux[i] = OR();
        aux[i].a <== a[i];
        aux[i].b <== b[i];
    }
    for (i=0; i<n; i++) {
        out[i] <== aux[i].out;
    }
}

template AndArray(n) {
    signal input a[n];
    signal input b[n];
    signal output out[n];
    var i;

    component aux[n];
    for (i=0; i<n; i++) {
        aux[i] = AND();
        aux[i].a <== a[i];
        aux[i].b <== b[i];
    }
    for (i=0; i<n; i++) {
        out[i] <== aux[i].out;
    }
}
//右移r位
template ShL(n, r) {
    signal input in[n];
    signal output out[n];

    for (var i=0; i<n; i++) {
        if (i < r) {
            out[i] <== 0;
        } else {
            out[i] <== in[ i-r ];
        }
    }
}
// template ShL(n, l) {
//     signal input in[n];
//     signal output out[n];

//     for (var i=0; i<n; i++) {
//         if (i+l > n) {
//             out[i] <== 0;
//         } else {
//             out[i] <== in[ i+l ];
//         }
//     }
// }