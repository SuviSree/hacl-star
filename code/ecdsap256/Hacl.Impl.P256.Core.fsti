module Hacl.Impl.P256.Core

open FStar.HyperStack.All
open FStar.HyperStack
open FStar.HyperStack.ST

module ST = FStar.HyperStack.ST
module HS = FStar.HyperStack

open Lib.IntTypes
open Lib.Buffer

open Hacl.Lemmas.P256
open Hacl.Spec.P256.Definition
open Hacl.Spec.P256.MontgomeryMultiplication

open Spec.P256

open Lib.Loops
open FStar.Math.Lemmas

module B = LowStar.Buffer
open FStar.Mul

inline_for_extraction noextract 
val toDomain: #c: curve -> value: felem c -> result: felem c ->  Stack unit 
  (requires fun h ->  as_nat c h value < prime256 /\ live h value /\live h result /\ eq_or_disjoint value result)
  (ensures fun h0 _ h1 -> modifies (loc result) h0 h1 /\ as_nat c h1 result = toDomain_ #c (as_nat c h0 value))
 
 
inline_for_extraction noextract
val fromDomain: #c: curve -> f: felem c -> result: felem c -> Stack unit 
  (requires fun h -> live h f /\ live h result /\ as_nat c h f < prime256)
  (ensures fun h0 _ h1 -> modifies (loc result) h0 h1 /\ 
    as_nat c h1 result = (as_nat c h0 f * modp_inv2 #c (pow2 256)) % prime256 /\ 
    as_nat c h1 result = fromDomain_ #c (as_nat c h0 f))


noextract 
let point_x_as_nat (c: curve) (h: mem) (e: point c) : GTot nat = 
  let open Lib.Sequence in 
  let s = as_seq h e in 
  let s0 = s.[0] in
  let s1 = s.[1] in 
  let s2 = s.[2] in 
  let s3 = s.[3] in 
  as_nat4 (s0, s1, s2, s3)

noextract 
let point_y_as_nat (c: curve) (h: mem) (e: point c) : GTot nat = 
  let open Lib.Sequence in 
  let s = as_seq h e in 
  let s0 = s.[4] in
  let s1 = s.[5] in 
  let s2 = s.[6] in 
  let s3 = s.[7] in 
  as_nat4 (s0, s1, s2, s3)

noextract 
let point_z_as_nat (c: curve) (h: mem) (e: point c) : GTot nat = 
  let open Lib.Sequence in 
  let s = as_seq h e in 
  let s0 = s.[8] in
  let s1 = s.[9] in 
  let s2 = s.[10] in 
  let s3 = s.[11] in 
  as_nat4 (s0, s1, s2, s3)


val pointToDomain: #c: curve -> p: point c -> result: point c -> Stack unit 
  (requires fun h -> live h p /\ live h result /\ eq_or_disjoint p result /\ 
    point_x_as_nat c h p < prime256 /\ point_y_as_nat c h p < prime256 /\ point_z_as_nat c h p < prime256)
  (ensures fun h0 _ h1 -> modifies (loc result) h0 h1 /\ 
    point_x_as_nat c h1 result == toDomain_ #c (point_x_as_nat c h0 p) /\
    point_y_as_nat c h1 result == toDomain_ #c (point_y_as_nat c h0 p) /\
    point_z_as_nat c h1 result == toDomain_ #c (point_z_as_nat c h0 p))


val pointFromDomain: #c : curve -> p: point c -> result: point c-> Stack unit 
  (requires fun h -> live h p /\ live h result /\ eq_or_disjoint p result /\ 
  point_x_as_nat c h p < prime256 /\ point_y_as_nat c h p < prime256 /\ point_z_as_nat c h p < prime256)
  (ensures fun h0 _ h1 -> modifies (loc result) h0 h1 /\
    point_x_as_nat c h1 result == fromDomain_ #c (point_x_as_nat c h0 p) /\
    point_y_as_nat c h1 result == fromDomain_ #c (point_y_as_nat c h0 p) /\
    point_z_as_nat c h1 result == fromDomain_ #c (point_z_as_nat c h0 p))
    

val isPointAtInfinityPrivate: #c: curve -> p: point c -> Stack uint64
  (requires fun h -> live h p /\ as_nat c h (gsub p (size 8) (size 4)) < prime256)
  (ensures fun h0 r h1 -> modifies0 h0 h1 /\      
    (
      (uint_v r == 0 \/ uint_v r == maxint U64) /\ 
      (
	let x, y, z = fromDomainPoint #c (point_prime_to_coordinates (as_seq h0 p)) in 
	if Spec.P256.isPointAtInfinity (x, y, z) then uint_v r = maxint U64 else uint_v r = 0
      ) /\
      (
	let x, y, z = point_prime_to_coordinates (as_seq h0 p) in 
	if Spec.P256.isPointAtInfinity (x, y, z) then uint_v r = maxint U64 else uint_v r = 0
      )
   )
  )

val norm: #c: curve -> p: point c -> resultPoint: point c -> tempBuffer: lbuffer uint64 (size 88) -> Stack unit
  (requires fun h -> live h p /\ live h resultPoint /\ live h tempBuffer /\ disjoint p tempBuffer /\ disjoint tempBuffer resultPoint /\ 
    as_nat c h (gsub p (size 0) (size 4)) < prime256 /\
    as_nat c h (gsub p (size 4) (size 4)) < prime256 /\
    as_nat c h (gsub p (size 8) (size 4)) < prime256 
  ) 
  (ensures fun h0 _ h1 -> 
      modifies (loc tempBuffer |+| loc resultPoint) h0 h1 /\
      (
      let resultPoint =  point_prime_to_coordinates (as_seq h1 resultPoint) in 
      let pointD = fromDomainPoint #c (point_prime_to_coordinates (as_seq h0 p)) in 
      let pointNorm = _norm #P256 pointD in 
      pointNorm == resultPoint
   )   
  )


val normX: #c: curve -> p: point c -> result: felem c -> tempBuffer: lbuffer uint64 (size 88) -> Stack unit
  (requires fun h -> live h p /\ live h result /\ live h tempBuffer /\
    LowStar.Monotonic.Buffer.all_disjoint [loc p; loc result; loc tempBuffer] /\ 
    as_nat c h (gsub p (size 0) (size 4)) < prime256 /\
    as_nat c h (gsub p (size 4) (size 4)) < prime256 /\
    as_nat c h (gsub p (size 8) (size 4)) < prime256 
  ) 
  (ensures fun h0 _ h1 -> 
      modifies (loc tempBuffer |+| loc result) h0 h1  /\
      (
	let pxD = fromDomain_ #c (as_nat c h0 (gsub p (size 0) (size 4))) in 
	let pyD = fromDomain_ #c (as_nat c h0 (gsub p (size 4) (size 4))) in 
	let pzD = fromDomain_ #c (as_nat c h0 (gsub p (size 8) (size 4))) in 
      
	let (xN, _, _) = _norm #P256 (pxD, pyD, pzD) in 
	as_nat c h1 result == xN
      )
  )



inline_for_extraction noextract
val scalarMultiplication: #c: curve -> #buf_type: buftype->  p: point c -> result: point c -> 
  scalar: lbuffer_t buf_type uint8 (size 32) -> 
  tempBuffer: lbuffer uint64 (size 100) ->
  Stack unit
    (requires fun h -> 
      live h p /\ live h result /\ live h scalar /\ live h tempBuffer /\
    LowStar.Monotonic.Buffer.all_disjoint [loc p; loc tempBuffer; loc scalar; loc result] /\
    as_nat c h (gsub p (size 0) (size 4)) < prime256 /\ 
    as_nat c h (gsub p (size 4) (size 4)) < prime256 /\
    as_nat c h (gsub p (size 8) (size 4)) < prime256
    )
  (ensures fun h0 _ h1 -> 
    modifies3 p result tempBuffer h0 h1 /\ 
    modifies (loc p |+| loc result |+| loc tempBuffer) h0 h1 /\
    as_nat c h1 (gsub result (size 0) (size 4)) < prime256 /\ 
    as_nat c h1 (gsub result (size 4) (size 4)) < prime256 /\
    as_nat c h1 (gsub result (size 8) (size 4)) < prime256 /\
    (
      let x3, y3, z3 = point_x_as_nat c h1 result, point_y_as_nat c h1 result, point_z_as_nat c h1 result in 
      let (xN, yN, zN) = scalar_multiplication #P256 (as_seq h0 scalar) (point_prime_to_coordinates (as_seq h0 p)) in 
      x3 == xN /\ y3 == yN /\ z3 == zN 
  )
) 


val scalarMultiplicationWithoutNorm: #c: curve -> p: point c -> result: point c -> 
  scalar: lbuffer  uint8 (size 32) -> 
  tempBuffer: lbuffer uint64 (size 100) ->
  Stack unit
    (requires fun h -> 
      live h p /\ live h result /\ live h scalar /\ live h tempBuffer /\
    LowStar.Monotonic.Buffer.all_disjoint [loc p; loc tempBuffer; loc scalar; loc result] /\
    as_nat c h (gsub p (size 0) (size 4)) < prime256 /\ 
    as_nat c h (gsub p (size 4) (size 4)) < prime256 /\
    as_nat c h (gsub p (size 8) (size 4)) < prime256
    )
  (ensures fun h0 _ h1 -> 
    modifies (loc p |+| loc result |+| loc tempBuffer) h0 h1 /\ 
    
    as_nat c h1 (gsub result (size 0) (size 4)) < prime256 /\ 
    as_nat c h1 (gsub result (size 4) (size 4)) < prime256 /\
    as_nat c h1 (gsub result (size 8) (size 4)) < prime256 /\
    
    modifies (loc p |+| loc result |+| loc tempBuffer) h0 h1 /\
    (
      let p1 = fromDomainPoint #c (point_prime_to_coordinates (as_seq h1 result)) in 
      let rN, _ = montgomery_ladder_spec #P256 (as_seq h0 scalar) ((0, 0, 0),  point_prime_to_coordinates (as_seq h0 p)) in 
      rN == p1
  )
) 


val secretToPublic: #c: curve -> result: point c  -> scalar: lbuffer uint8 (size 32) -> tempBuffer: lbuffer uint64 (size 100) ->
  Stack unit
    (requires fun h -> 
      live h result /\ live h scalar /\ live h tempBuffer /\ 
      LowStar.Monotonic.Buffer.all_disjoint [loc tempBuffer; loc scalar; loc result]
    )
  (
    ensures fun h0 _ h1 -> modifies (loc result |+| loc tempBuffer) h0 h1 /\
    as_nat c h1 (gsub result (size 0) (size 4)) < prime256 /\ 
    as_nat c h1 (gsub result (size 4) (size 4)) < prime256 /\ 
    as_nat c h1 (gsub result (size 8) (size 4)) < prime256 /\
    (
      let x3, y3, z3 = point_x_as_nat c h1 result, point_y_as_nat c h1 result, point_z_as_nat c h1 result in 
      let (xN, yN, zN) = secret_to_public #P256 (as_seq h0 scalar)  in 
      x3 == xN /\ y3 == yN /\ z3 == zN 
    )
  )

val secretToPublicWithoutNorm: #c: curve -> result: point c -> scalar: lbuffer uint8 (size 32) -> 
 tempBuffer: lbuffer uint64 (size 100) ->
  Stack unit
    (requires fun h -> 
      live h result /\ live h scalar /\ live h tempBuffer /\
      LowStar.Monotonic.Buffer.all_disjoint [loc tempBuffer; loc scalar; loc result]
    )
  (
    ensures fun h0 _ h1 -> modifies (loc result |+| loc tempBuffer) h0 h1 /\
      as_nat c h1 (gsub result (size 0) (size 4)) < prime256 /\ 
      as_nat c h1 (gsub result (size 4) (size 4)) < prime256 /\ 
      as_nat c h1 (gsub result (size 8) (size 4)) < prime256 /\
      (
	let p1 = fromDomainPoint #c (point_prime_to_coordinates (as_seq h1 result)) in 
	let rN, _ = montgomery_ladder_spec (as_seq h0 scalar) ((0, 0, 0), (basePoint #P256)) in 
	rN == p1))  