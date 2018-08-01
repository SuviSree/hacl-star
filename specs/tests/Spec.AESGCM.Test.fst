module Spec.AESGCM.Test

#reset-options "--z3rlimit 100 --initial_fuel 0 --max_fuel 0 --initial_ifuel 0"

open FStar.Mul
open Lib.IntTypes
open Lib.RawIntTypes
open Lib.Sequence
open Lib.ByteSequence
//open Lib.Stateful

module AEAD = Spec.AESGCM

let key_length = 16

let test1_key = List.Tot.map u8 [
0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00
]

let test1_nonce = List.Tot.map u8 [
0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00
]

let test1_msg = List.Tot.map u8 [

]

let test1_aad = List.Tot.map u8 [

]

let test1_expected = List.Tot.map u8 [
0x58; 0xe2; 0xfc; 0xce; 0xfa; 0x7e; 0x30; 0x61; 0x36; 0x7f; 0x1d; 0x57; 0xa4; 0xe7; 0x45; 0x5a
]

let test1_ciphertext = List.Tot.map u8 [

]

let test1_hash_key = List.Tot.map u8 [
0x66; 0xe9; 0x4b; 0xd4; 0xef; 0x8a; 0x2c; 0x3b; 0x88; 0x4c; 0xfa; 0x59; 0xca; 0x34; 0x2b; 0x2e
]

let test1_ghash = List.Tot.map u8 [
0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00
]

let test1_nonce_length: size_nat = 12
let test1_msg_length: size_nat = 0
let test1_aad_length: size_nat = 0
let test1_c_length: size_nat = 0

let test2_key = List.Tot.map u8 [
0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00
]

let test2_nonce = List.Tot.map u8 [
0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00
]

let test2_msg = List.Tot.map u8 [
0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00
]

let test2_aad = List.Tot.map u8 [

]

let test2_expected = List.Tot.map u8 [
0x03; 0x88; 0xda; 0xce; 0x60; 0xb6; 0xa3; 0x92; 0xf3; 0x28; 0xc2; 0xb9; 0x71; 0xb2; 0xfe; 0x78; 0xab; 0x6e; 0x47; 0xd4; 0x2c; 0xec; 0x13; 0xbd; 0xf5; 0x3a; 0x67; 0xb2; 0x12; 0x57; 0xbd; 0xdf
]

let test2_ciphertext = List.Tot.map u8 [
0x03; 0x88; 0xda; 0xce; 0x60; 0xb6; 0xa3; 0x92; 0xf3; 0x28; 0xc2; 0xb9; 0x71; 0xb2; 0xfe; 0x78
]

let test2_hash_key = List.Tot.map u8 [
0x66; 0xe9; 0x4b; 0xd4; 0xef; 0x8a; 0x2c; 0x3b; 0x88; 0x4c; 0xfa; 0x59; 0xca; 0x34; 0x2b; 0x2e
]

let test2_ghash = List.Tot.map u8 [
0xf3; 0x8c; 0xbb; 0x1a; 0xd6; 0x92; 0x23; 0xdc; 0xc3; 0x45; 0x7a; 0xe5; 0xb6; 0xb0; 0xf8; 0x85
]

let test2_nonce_length: size_nat = 12
let test2_msg_length: size_nat = 16
let test2_aad_length: size_nat = 0
let test2_c_length: size_nat = 16

let test3_key = List.Tot.map u8 [
0xfe; 0xff; 0xe9; 0x92; 0x86; 0x65; 0x73; 0x1c; 0x6d; 0x6a; 0x8f; 0x94; 0x67; 0x30; 0x83; 0x08
]

let test3_nonce = List.Tot.map u8 [
0xca; 0xfe; 0xba; 0xbe; 0xfa; 0xce; 0xdb; 0xad; 0xde; 0xca; 0xf8; 0x88
]

let test3_msg = List.Tot.map u8 [
0xd9; 0x31; 0x32; 0x25; 0xf8; 0x84; 0x06; 0xe5; 0xa5; 0x59; 0x09; 0xc5; 0xaf; 0xf5; 0x26; 0x9a; 0x86; 0xa7; 0xa9; 0x53; 0x15; 0x34; 0xf7; 0xda; 0x2e; 0x4c; 0x30; 0x3d; 0x8a; 0x31; 0x8a; 0x72; 0x1c; 0x3c; 0x0c; 0x95; 0x95; 0x68; 0x09; 0x53; 0x2f; 0xcf; 0x0e; 0x24; 0x49; 0xa6; 0xb5; 0x25; 0xb1; 0x6a; 0xed; 0xf5; 0xaa; 0x0d; 0xe6; 0x57; 0xba; 0x63; 0x7b; 0x39; 0x1a; 0xaf; 0xd2; 0x55
]

let test3_aad = List.Tot.map u8 [

]

let test3_expected = List.Tot.map u8 [
0x42; 0x83; 0x1e; 0xc2; 0x21; 0x77; 0x74; 0x24; 0x4b; 0x72; 0x21; 0xb7; 0x84; 0xd0; 0xd4; 0x9c; 0xe3; 0xaa; 0x21; 0x2f; 0x2c; 0x02; 0xa4; 0xe0; 0x35; 0xc1; 0x7e; 0x23; 0x29; 0xac; 0xa1; 0x2e; 0x21; 0xd5; 0x14; 0xb2; 0x54; 0x66; 0x93; 0x1c; 0x7d; 0x8f; 0x6a; 0x5a; 0xac; 0x84; 0xaa; 0x05; 0x1b; 0xa3; 0x0b; 0x39; 0x6a; 0x0a; 0xac; 0x97; 0x3d; 0x58; 0xe0; 0x91; 0x47; 0x3f; 0x59; 0x85; 0x4d; 0x5c; 0x2a; 0xf3; 0x27; 0xcd; 0x64; 0xa6; 0x2c; 0xf3; 0x5a; 0xbd; 0x2b; 0xa6; 0xfa; 0xb4
]

let test3_ciphertext = List.Tot.map u8 [
0x42; 0x83; 0x1e; 0xc2; 0x21; 0x77; 0x74; 0x24; 0x4b; 0x72; 0x21; 0xb7; 0x84; 0xd0; 0xd4; 0x9c; 0xe3; 0xaa; 0x21; 0x2f; 0x2c; 0x02; 0xa4; 0xe0; 0x35; 0xc1; 0x7e; 0x23; 0x29; 0xac; 0xa1; 0x2e; 0x21; 0xd5; 0x14; 0xb2; 0x54; 0x66; 0x93; 0x1c; 0x7d; 0x8f; 0x6a; 0x5a; 0xac; 0x84; 0xaa; 0x05; 0x1b; 0xa3; 0x0b; 0x39; 0x6a; 0x0a; 0xac; 0x97; 0x3d; 0x58; 0xe0; 0x91; 0x47; 0x3f; 0x59; 0x85
]

let test3_hash_key = List.Tot.map u8 [
0xb8; 0x3b; 0x53; 0x37; 0x08; 0xbf; 0x53; 0x5d; 0x0a; 0xa6; 0xe5; 0x29; 0x80; 0xd5; 0x3b; 0x78
]

let test3_ghash = List.Tot.map u8 [
0x7f; 0x1b; 0x32; 0xb8; 0x1b; 0x82; 0x0d; 0x02; 0x61; 0x4f; 0x88; 0x95; 0xac; 0x1d; 0x4e; 0xac
]

let test3_nonce_length: size_nat = 12
let test3_msg_length: size_nat = 64
let test3_aad_length: size_nat = 0
let test3_c_length: size_nat = 64

let test4_key = List.Tot.map u8 [
0xfe; 0xff; 0xe9; 0x92; 0x86; 0x65; 0x73; 0x1c; 0x6d; 0x6a; 0x8f; 0x94; 0x67; 0x30; 0x83; 0x08
]

let test4_nonce = List.Tot.map u8 [
0xca; 0xfe; 0xba; 0xbe; 0xfa; 0xce; 0xdb; 0xad; 0xde; 0xca; 0xf8; 0x88
]

let test4_msg = List.Tot.map u8 [
0xd9; 0x31; 0x32; 0x25; 0xf8; 0x84; 0x06; 0xe5; 0xa5; 0x59; 0x09; 0xc5; 0xaf; 0xf5; 0x26; 0x9a; 0x86; 0xa7; 0xa9; 0x53; 0x15; 0x34; 0xf7; 0xda; 0x2e; 0x4c; 0x30; 0x3d; 0x8a; 0x31; 0x8a; 0x72; 0x1c; 0x3c; 0x0c; 0x95; 0x95; 0x68; 0x09; 0x53; 0x2f; 0xcf; 0x0e; 0x24; 0x49; 0xa6; 0xb5; 0x25; 0xb1; 0x6a; 0xed; 0xf5; 0xaa; 0x0d; 0xe6; 0x57; 0xba; 0x63; 0x7b; 0x39
]

let test4_aad = List.Tot.map u8 [
0xfe; 0xed; 0xfa; 0xce; 0xde; 0xad; 0xbe; 0xef; 0xfe; 0xed; 0xfa; 0xce; 0xde; 0xad; 0xbe; 0xef; 0xab; 0xad; 0xda; 0xd2
]

let test4_expected = List.Tot.map u8 [
0x42; 0x83; 0x1e; 0xc2; 0x21; 0x77; 0x74; 0x24; 0x4b; 0x72; 0x21; 0xb7; 0x84; 0xd0; 0xd4; 0x9c; 0xe3; 0xaa; 0x21; 0x2f; 0x2c; 0x02; 0xa4; 0xe0; 0x35; 0xc1; 0x7e; 0x23; 0x29; 0xac; 0xa1; 0x2e; 0x21; 0xd5; 0x14; 0xb2; 0x54; 0x66; 0x93; 0x1c; 0x7d; 0x8f; 0x6a; 0x5a; 0xac; 0x84; 0xaa; 0x05; 0x1b; 0xa3; 0x0b; 0x39; 0x6a; 0x0a; 0xac; 0x97; 0x3d; 0x58; 0xe0; 0x91; 0x5b; 0xc9; 0x4f; 0xbc; 0x32; 0x21; 0xa5; 0xdb; 0x94; 0xfa; 0xe9; 0x5a; 0xe7; 0x12; 0x1a; 0x47
]

let test4_ciphertext = List.Tot.map u8 [
0x42; 0x83; 0x1e; 0xc2; 0x21; 0x77; 0x74; 0x24; 0x4b; 0x72; 0x21; 0xb7; 0x84; 0xd0; 0xd4; 0x9c; 0xe3; 0xaa; 0x21; 0x2f; 0x2c; 0x02; 0xa4; 0xe0; 0x35; 0xc1; 0x7e; 0x23; 0x29; 0xac; 0xa1; 0x2e; 0x21; 0xd5; 0x14; 0xb2; 0x54; 0x66; 0x93; 0x1c; 0x7d; 0x8f; 0x6a; 0x5a; 0xac; 0x84; 0xaa; 0x05; 0x1b; 0xa3; 0x0b; 0x39; 0x6a; 0x0a; 0xac; 0x97; 0x3d; 0x58; 0xe0; 0x91
]

let test4_hash_key = List.Tot.map u8 [
0xb8; 0x3b; 0x53; 0x37; 0x08; 0xbf; 0x53; 0x5d; 0x0a; 0xa6; 0xe5; 0x29; 0x80; 0xd5; 0x3b; 0x78
]

let test4_ghash = List.Tot.map u8 [
0x69; 0x8e; 0x57; 0xf7; 0x0e; 0x6e; 0xcc; 0x7f; 0xd9; 0x46; 0x3b; 0x72; 0x60; 0xa9; 0xae; 0x5f
]

let test4_nonce_length: size_nat = 12
let test4_msg_length: size_nat = 60
let test4_aad_length: size_nat = 20
let test4_c_length: size_nat = 60

let test5_key = List.Tot.map u8 [
0xfe; 0xff; 0xe9; 0x92; 0x86; 0x65; 0x73; 0x1c; 0x6d; 0x6a; 0x8f; 0x94; 0x67; 0x30; 0x83; 0x08
]

let test5_nonce = List.Tot.map u8 [
0xca; 0xfe; 0xba; 0xbe; 0xfa; 0xce; 0xdb; 0xad
]

let test5_msg = List.Tot.map u8 [
0xd9; 0x31; 0x32; 0x25; 0xf8; 0x84; 0x06; 0xe5; 0xa5; 0x59; 0x09; 0xc5; 0xaf; 0xf5; 0x26; 0x9a; 0x86; 0xa7; 0xa9; 0x53; 0x15; 0x34; 0xf7; 0xda; 0x2e; 0x4c; 0x30; 0x3d; 0x8a; 0x31; 0x8a; 0x72; 0x1c; 0x3c; 0x0c; 0x95; 0x95; 0x68; 0x09; 0x53; 0x2f; 0xcf; 0x0e; 0x24; 0x49; 0xa6; 0xb5; 0x25; 0xb1; 0x6a; 0xed; 0xf5; 0xaa; 0x0d; 0xe6; 0x57; 0xba; 0x63; 0x7b; 0x39
]

let test5_aad = List.Tot.map u8 [
0xfe; 0xed; 0xfa; 0xce; 0xde; 0xad; 0xbe; 0xef; 0xfe; 0xed; 0xfa; 0xce; 0xde; 0xad; 0xbe; 0xef; 0xab; 0xad; 0xda; 0xd2
]

let test5_expected = List.Tot.map u8 [
0x61; 0x35; 0x3b; 0x4c; 0x28; 0x06; 0x93; 0x4a; 0x77; 0x7f; 0xf5; 0x1f; 0xa2; 0x2a; 0x47; 0x55; 0x69; 0x9b; 0x2a; 0x71; 0x4f; 0xcd; 0xc6; 0xf8; 0x37; 0x66; 0xe5; 0xf9; 0x7b; 0x6c; 0x74; 0x23; 0x73; 0x80; 0x69; 0x00; 0xe4; 0x9f; 0x24; 0xb2; 0x2b; 0x09; 0x75; 0x44; 0xd4; 0x89; 0x6b; 0x42; 0x49; 0x89; 0xb5; 0xe1; 0xeb; 0xac; 0x0f; 0x07; 0xc2; 0x3f; 0x45; 0x98; 0x36; 0x12; 0xd2; 0xe7; 0x9e; 0x3b; 0x07; 0x85; 0x56; 0x1b; 0xe1; 0x4a; 0xac; 0xa2; 0xfc; 0xcb
]

let test5_ciphertext = List.Tot.map u8 [
0x61; 0x35; 0x3b; 0x4c; 0x28; 0x06; 0x93; 0x4a; 0x77; 0x7f; 0xf5; 0x1f; 0xa2; 0x2a; 0x47; 0x55; 0x69; 0x9b; 0x2a; 0x71; 0x4f; 0xcd; 0xc6; 0xf8; 0x37; 0x66; 0xe5; 0xf9; 0x7b; 0x6c; 0x74; 0x23; 0x73; 0x80; 0x69; 0x00; 0xe4; 0x9f; 0x24; 0xb2; 0x2b; 0x09; 0x75; 0x44; 0xd4; 0x89; 0x6b; 0x42; 0x49; 0x89; 0xb5; 0xe1; 0xeb; 0xac; 0x0f; 0x07; 0xc2; 0x3f; 0x45; 0x98
]

let test5_hash_key = List.Tot.map u8 [
0xb8; 0x3b; 0x53; 0x37; 0x08; 0xbf; 0x53; 0x5d; 0x0a; 0xa6; 0xe5; 0x29; 0x80; 0xd5; 0x3b; 0x78
]

let test5_ghash = List.Tot.map u8 [
0xdf; 0x58; 0x6b; 0xb4; 0xc2; 0x49; 0xb9; 0x2c; 0xb6; 0x92; 0x28; 0x77; 0xe4; 0x44; 0xd3; 0x7b
]

let test5_nonce_length: size_nat = 8
let test5_msg_length: size_nat = 60
let test5_aad_length: size_nat = 20
let test5_c_length: size_nat = 60

let test6_key = List.Tot.map u8 [
0xfe; 0xff; 0xe9; 0x92; 0x86; 0x65; 0x73; 0x1c; 0x6d; 0x6a; 0x8f; 0x94; 0x67; 0x30; 0x83; 0x08
]

let test6_nonce = List.Tot.map u8 [
0x93; 0x13; 0x22; 0x5d; 0xf8; 0x84; 0x06; 0xe5; 0x55; 0x90; 0x9c; 0x5a; 0xff; 0x52; 0x69; 0xaa; 0x6a; 0x7a; 0x95; 0x38; 0x53; 0x4f; 0x7d; 0xa1; 0xe4; 0xc3; 0x03; 0xd2; 0xa3; 0x18; 0xa7; 0x28; 0xc3; 0xc0; 0xc9; 0x51; 0x56; 0x80; 0x95; 0x39; 0xfc; 0xf0; 0xe2; 0x42; 0x9a; 0x6b; 0x52; 0x54; 0x16; 0xae; 0xdb; 0xf5; 0xa0; 0xde; 0x6a; 0x57; 0xa6; 0x37; 0xb3; 0x9b
]

let test6_msg = List.Tot.map u8 [
0xd9; 0x31; 0x32; 0x25; 0xf8; 0x84; 0x06; 0xe5; 0xa5; 0x59; 0x09; 0xc5; 0xaf; 0xf5; 0x26; 0x9a; 0x86; 0xa7; 0xa9; 0x53; 0x15; 0x34; 0xf7; 0xda; 0x2e; 0x4c; 0x30; 0x3d; 0x8a; 0x31; 0x8a; 0x72; 0x1c; 0x3c; 0x0c; 0x95; 0x95; 0x68; 0x09; 0x53; 0x2f; 0xcf; 0x0e; 0x24; 0x49; 0xa6; 0xb5; 0x25; 0xb1; 0x6a; 0xed; 0xf5; 0xaa; 0x0d; 0xe6; 0x57; 0xba; 0x63; 0x7b; 0x39
]

let test6_aad = List.Tot.map u8 [
0xfe; 0xed; 0xfa; 0xce; 0xde; 0xad; 0xbe; 0xef; 0xfe; 0xed; 0xfa; 0xce; 0xde; 0xad; 0xbe; 0xef; 0xab; 0xad; 0xda; 0xd2
]

let test6_expected = List.Tot.map u8 [
0x8c; 0xe2; 0x49; 0x98; 0x62; 0x56; 0x15; 0xb6; 0x03; 0xa0; 0x33; 0xac; 0xa1; 0x3f; 0xb8; 0x94; 0xbe; 0x91; 0x12; 0xa5; 0xc3; 0xa2; 0x11; 0xa8; 0xba; 0x26; 0x2a; 0x3c; 0xca; 0x7e; 0x2c; 0xa7; 0x01; 0xe4; 0xa9; 0xa4; 0xfb; 0xa4; 0x3c; 0x90; 0xcc; 0xdc; 0xb2; 0x81; 0xd4; 0x8c; 0x7c; 0x6f; 0xd6; 0x28; 0x75; 0xd2; 0xac; 0xa4; 0x17; 0x03; 0x4c; 0x34; 0xae; 0xe5; 0x61; 0x9c; 0xc5; 0xae; 0xff; 0xfe; 0x0b; 0xfa; 0x46; 0x2a; 0xf4; 0x3c; 0x16; 0x99; 0xd0; 0x50
]

let test6_ciphertext = List.Tot.map u8 [
0x8c; 0xe2; 0x49; 0x98; 0x62; 0x56; 0x15; 0xb6; 0x03; 0xa0; 0x33; 0xac; 0xa1; 0x3f; 0xb8; 0x94; 0xbe; 0x91; 0x12; 0xa5; 0xc3; 0xa2; 0x11; 0xa8; 0xba; 0x26; 0x2a; 0x3c; 0xca; 0x7e; 0x2c; 0xa7; 0x01; 0xe4; 0xa9; 0xa4; 0xfb; 0xa4; 0x3c; 0x90; 0xcc; 0xdc; 0xb2; 0x81; 0xd4; 0x8c; 0x7c; 0x6f; 0xd6; 0x28; 0x75; 0xd2; 0xac; 0xa4; 0x17; 0x03; 0x4c; 0x34; 0xae; 0xe5
]

let test6_hash_key = List.Tot.map u8 [
0xb8; 0x3b; 0x53; 0x37; 0x08; 0xbf; 0x53; 0x5d; 0x0a; 0xa6; 0xe5; 0x29; 0x80; 0xd5; 0x3b; 0x78
]

let test6_ghash = List.Tot.map u8 [
0x1c; 0x5a; 0xfe; 0x97; 0x60; 0xd3; 0x93; 0x2f; 0x3c; 0x9a; 0x87; 0x8a; 0xac; 0x3d; 0xc3; 0xde
]

let test6_nonce_length: size_nat = 60
let test6_msg_length: size_nat = 60
let test6_aad_length: size_nat = 20
let test6_c_length: size_nat = 60

val test_aesgcm:
  text_len:size_nat ->
  text:lbytes text_len ->
  aad_len:size_nat ->
  aad:lbytes aad_len ->
  n_len:size_nat ->
  n:lbytes n_len ->
  k:lbytes key_length ->
  expected:lbytes (16 + text_len) ->
  i:size_nat ->
  FStar.All.ML unit

let test_aesgcm text_len text aad_len aad n_len n k expected i =
  IO.print_string " ================================ CIPHER ";
  IO.print_string (UInt8.to_string (u8_to_UInt8 (u8 i)));
  IO.print_string " ================================\n";
  let ciphertext = AEAD.aead_encrypt k n_len n text_len text aad_len aad in
  let decrypted = AEAD.aead_decrypt k n_len n (text_len + 16) ciphertext aad_len aad in
  let result0 = for_all2 (fun a b -> uint_to_nat #U8 a = uint_to_nat #U8 b) ciphertext expected in
  let result1 = for_all2 (fun a b -> uint_to_nat #U8 a = uint_to_nat #U8 b) decrypted text in
  if result0 && result1 then IO.print_string "Success!\n"
  else (IO.print_string "Failure!\n";
    IO.print_string  "\nExpected ciphertext: ";
    List.iter (fun a -> IO.print_uint8 (u8_to_UInt8 a);  IO.print_string ":") (as_list expected);
    IO.print_string "\nComputed ciphertext: ";
    List.iter (fun a -> IO.print_uint8 (u8_to_UInt8 a);  IO.print_string ":") (as_list ciphertext);
    IO.print_string "\nExpected plaintext: ";
    List.iter (fun a -> IO.print_uint8 (u8_to_UInt8 a);  IO.print_string ":") (as_list text);
    IO.print_string "\nComputed plaintext: ";
    List.iter (fun a -> IO.print_uint8 (u8_to_UInt8 a);  IO.print_string ":") (as_list decrypted);
    IO.print_string "\n")


val test_ghash:
  expected:lbytes AEAD.blocksize ->
  text_len:size_nat ->
  text:lbytes text_len ->
  aad_len:size_nat ->
  aad:lbytes aad_len ->
  k:lbytes key_length ->
  i:size_nat ->
  FStar.All.ML unit

let test_ghash expected text_len text aad_len aad k i =
  IO.print_string " ================================ GHASH ";
  IO.print_string (UInt8.to_string (u8_to_UInt8 (u8 i)));
  IO.print_string " ================================\n";
  let output = AEAD.ghash text_len text aad_len aad (create 16 (u8 0)) k in
  let result = for_all2 (fun a b -> uint_to_nat #U8 a = uint_to_nat #U8 b) output expected in
  if result then IO.print_string "Success!\n"
  else (
    IO.print_string "Failure :(\n";
    IO.print_string   "Expected tag: ";
    List.iter (fun a -> IO.print_uint8 (u8_to_UInt8 a);  IO.print_string ":") (as_list expected);
    IO.print_string "\nComputed tag: ";
    List.iter (fun a -> IO.print_uint8 (u8_to_UInt8 a);  IO.print_string ":") (as_list output);
    IO.print_string "\n"
  )

let test () =
  test_ghash (createL test1_ghash) test1_c_length (createL test1_ciphertext) test1_aad_length (createL test1_aad) (createL test1_key) 1;
  test_aesgcm test1_msg_length (createL test1_msg) test1_aad_length (createL test1_aad) test1_nonce_length (createL test1_nonce) (createL test1_key) (createL test1_expected) 1;
  test_ghash (createL test2_ghash) test2_c_length (createL test2_ciphertext) test2_aad_length (createL test2_aad) (createL test2_key) 2;
  test_aesgcm test2_msg_length (createL test2_msg) test2_aad_length (createL test2_aad) test2_nonce_length (createL test2_nonce) (createL test2_key) (createL test2_expected) 2;
  test_ghash (createL test3_ghash) test3_c_length (createL test3_ciphertext) test3_aad_length (createL test3_aad) (createL test3_key) 3;
  test_aesgcm test3_msg_length (createL test3_msg) test3_aad_length (createL test3_aad) test3_nonce_length (createL test3_nonce) (createL test3_key) (createL test3_expected) 3;
  test_ghash (createL test4_ghash) test4_c_length (createL test4_ciphertext) test4_aad_length (createL test4_aad) (createL test4_key) 4;
  test_aesgcm test4_msg_length (createL test4_msg) test4_aad_length (createL test4_aad) test4_nonce_length (createL test4_nonce) (createL test4_key) (createL test4_expected) 4;
  test_ghash (createL test5_ghash) test5_c_length (createL test5_ciphertext) test5_aad_length (createL test5_aad) (createL test5_key) 5;
  test_aesgcm test5_msg_length (createL test5_msg) test5_aad_length (createL test5_aad) test5_nonce_length (createL test5_nonce) (createL test5_key) (createL test5_expected) 5;
  test_ghash (createL test6_ghash) test6_c_length (createL test6_ciphertext) test6_aad_length (createL test6_aad) (createL test6_key) 6;
  test_aesgcm test6_msg_length (createL test6_msg) test6_aad_length (createL test6_aad) test6_nonce_length (createL test6_nonce) (createL test6_key) (createL test6_expected) 6;
  ()
