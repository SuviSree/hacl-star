module Hacl.Impl.P256.Arithmetics

open FStar.HyperStack.All
open FStar.HyperStack
module ST = FStar.HyperStack.ST

open Lib.IntTypes
open Lib.Buffer

open Hacl.Spec.P256.Lemmas
open Hacl.Spec.P256.Definitions

open Hacl.Impl.LowLevel
open Hacl.Impl.P256.LowLevel
open Hacl.Impl.P256.MontgomeryMultiplication
open Hacl.Spec.P256

open Hacl.Spec.P256.MontgomeryMultiplication

open FStar.Math.Lemmas
friend Hacl.Spec.P256.MontgomeryMultiplication
open Spec.P256.Field

open FStar.Mul

#reset-options "--z3rlimit 100" 

let quatre a result = 
    let h0 = ST.get() in 
  montgomery_multiplication_buffer a a result;
  montgomery_multiplication_buffer result result result;
    inDomain_mod_is_not_mod ((fromDomain_ (as_nat h0 a) * fromDomain_ (as_nat h0 a) % prime) * (fromDomain_ (as_nat h0 a) * fromDomain_ (as_nat h0 a) % prime));
    modulo_distributivity_mult2 (fromDomain_ (as_nat h0 a) * fromDomain_ (as_nat h0 a)) (fromDomain_ (as_nat h0 a) * fromDomain_ (as_nat h0 a)) 1 prime;
    lemma_brackets (fromDomain_ (as_nat h0 a) * fromDomain_ (as_nat h0 a)) (fromDomain_ (as_nat h0 a)) (fromDomain_ (as_nat h0 a));
    inDomain_mod_is_not_mod (fromDomain_ (as_nat h0 a) * fromDomain_ (as_nat h0 a) * fromDomain_ (as_nat h0 a) * fromDomain_ (as_nat h0 a))


let multByTwo a out = 
    let h0 = ST.get() in 
  p256_add a a out;
    inDomain_mod_is_not_mod (2 * fromDomain_ (as_nat h0 a))


let multByThree a result = 
    let h0 = ST.get() in 
  multByTwo a result;
    let h1 = ST.get() in 
      assert(as_nat h1 result == toDomain_ (2 * fromDomain_ (as_nat h0 a) % prime));
  p256_add a result result;
    let h2 = ST.get() in 
    lemma_mod_add_distr (fromDomain_ (as_nat h0 a)) (2 * fromDomain_ (as_nat h0 a)) prime;
    inDomain_mod_is_not_mod (3 * fromDomain_ (as_nat h0 a))
  

let multByFour a result  = 
    let h0 = ST.get() in 
  multByTwo a result;
  multByTwo result result;
    lemma_mod_mul_distr_r 2 (2 * fromDomain_ (as_nat h0 a)) prime;
    lemma_brackets 2 2 (fromDomain_ (as_nat h0 a)); 
    inDomain_mod_is_not_mod (4 * fromDomain_ (as_nat h0 a))


let multByEight a result  = 
    let h0 = ST.get() in 
  multByTwo a result;
  multByTwo result result;
    lemma_mod_mul_distr_r 2 (2 * fromDomain_ (as_nat h0 a)) prime;
    lemma_brackets 2 2 (fromDomain_ (as_nat h0 a)); 
    inDomain_mod_is_not_mod (4 * fromDomain_ (as_nat h0 a));
  multByTwo result result;
    lemma_mod_mul_distr_r 2 (4 * fromDomain_ (as_nat h0 a)) prime;
    lemma_brackets 2 4 (fromDomain_ (as_nat h0 a));
    inDomain_mod_is_not_mod (8 * fromDomain_ (as_nat h0 a))


let multByMinusThree a result  = 
  let h0 = ST.get() in 
    push_frame();
    multByThree a result;
    let zeros = create (size 4) (u64 0) in 
    p256_sub zeros result result;
      lemmaFromDomain 0; 
      assert_norm( 0 * modp_inv2 (pow2 256) % prime == 0);
      assert_norm (fromDomain_ 0 == 0); 
      lemma_mod_sub_distr 0 (3 * fromDomain_ (as_nat h0 a)) prime;
      inDomain_mod_is_not_mod ((-3) * fromDomain_ (as_nat h0 a));  
  pop_frame()

