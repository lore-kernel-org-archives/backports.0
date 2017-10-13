Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49562 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbdJMKTE (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 06:19:04 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] backports: reduce mbedtls bignum stack usage
Date: Fri, 13 Oct 2017 12:19:01 +0200
Message-Id: <20171013101901.25450-1-johannes@sipsolutions.net> (sfid-20171013_121906_330878_E94D80B4)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

mbedtls_mpi_exp_mod() uses almost 4k of memory, which
really shouldn't be on the stack in the kernel.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/compat/verification/bignum.c | 87 ++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 38 deletions(-)

diff --git a/backport/compat/verification/bignum.c b/backport/compat/verification/bignum.c
index 7edfb0837557..b8f65285cf53 100644
--- a/backport/compat/verification/bignum.c
+++ b/backport/compat/verification/bignum.c
@@ -1611,22 +1611,31 @@ int mbedtls_mpi_exp_mod( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi
     size_t i, j, nblimbs;
     size_t bufsize, nbits;
     mbedtls_mpi_uint ei, mm, state;
-    mbedtls_mpi RR, T, W[ 2 << MBEDTLS_MPI_WINDOW_SIZE ], Apos;
+    struct {
+	    mbedtls_mpi RR, T, W[ 2 << MBEDTLS_MPI_WINDOW_SIZE ], Apos;
+    } *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
     int neg;
 
-    if( mbedtls_mpi_cmp_int( N, 0 ) < 0 || ( N->p[0] & 1 ) == 0 )
-        return( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+    if (!ctx)
+        return -ENOMEM;
 
-    if( mbedtls_mpi_cmp_int( E, 0 ) < 0 )
-        return( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+    if( mbedtls_mpi_cmp_int( N, 0 ) < 0 || ( N->p[0] & 1 ) == 0 ) {
+        ret = ( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+        goto free_ctx;
+    }
+
+    if( mbedtls_mpi_cmp_int( E, 0 ) < 0 ) {
+        ret = ( MBEDTLS_ERR_MPI_BAD_INPUT_DATA );
+        goto free_ctx;
+    }
 
     /*
      * Init temps and window size
      */
     mpi_montg_init( &mm, N );
-    mbedtls_mpi_init( &RR ); mbedtls_mpi_init( &T );
-    mbedtls_mpi_init( &Apos );
-    memset( W, 0, sizeof( W ) );
+    mbedtls_mpi_init( &ctx->RR ); mbedtls_mpi_init( &ctx->T );
+    mbedtls_mpi_init( &ctx->Apos );
+    memset( ctx->W, 0, sizeof( ctx->W ) );
 
     i = mbedtls_mpi_bitlen( E );
 
@@ -1638,8 +1647,8 @@ int mbedtls_mpi_exp_mod( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi
 
     j = N->n + 1;
     MBEDTLS_MPI_CHK( mbedtls_mpi_grow( X, j ) );
-    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &W[1],  j ) );
-    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &T, j * 2 ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &ctx->W[1],  j ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &ctx->T, j * 2 ) );
 
     /*
      * Compensate for negative A (and correct at the end)
@@ -1647,9 +1656,9 @@ int mbedtls_mpi_exp_mod( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi
     neg = ( A->s == -1 );
     if( neg )
     {
-        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &Apos, A ) );
-        Apos.s = 1;
-        A = &Apos;
+        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &ctx->Apos, A ) );
+        ctx->Apos.s = 1;
+        A = &ctx->Apos;
     }
 
     /*
@@ -1657,31 +1666,31 @@ int mbedtls_mpi_exp_mod( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi
      */
     if( _RR == NULL || _RR->p == NULL )
     {
-        MBEDTLS_MPI_CHK( mbedtls_mpi_lset( &RR, 1 ) );
-        MBEDTLS_MPI_CHK( mbedtls_mpi_shift_l( &RR, N->n * 2 * biL ) );
-        MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &RR, &RR, N ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_lset( &ctx->RR, 1 ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_shift_l( &ctx->RR, N->n * 2 * biL ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &ctx->RR, &ctx->RR, N ) );
 
         if( _RR != NULL )
-            memcpy( _RR, &RR, sizeof( mbedtls_mpi ) );
+            memcpy( _RR, &ctx->RR, sizeof( mbedtls_mpi ) );
     }
     else
-        memcpy( &RR, _RR, sizeof( mbedtls_mpi ) );
+        memcpy( &ctx->RR, _RR, sizeof( mbedtls_mpi ) );
 
     /*
      * W[1] = A * R^2 * R^-1 mod N = A * R mod N
      */
     if( mbedtls_mpi_cmp_mpi( A, N ) >= 0 )
-        MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &W[1], A, N ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_mod_mpi( &ctx->W[1], A, N ) );
     else
-        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &W[1], A ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &ctx->W[1], A ) );
 
-    MBEDTLS_MPI_CHK( mpi_montmul( &W[1], &RR, N, mm, &T ) );
+    MBEDTLS_MPI_CHK( mpi_montmul( &ctx->W[1], &ctx->RR, N, mm, &ctx->T ) );
 
     /*
      * X = R^2 * R^-1 mod N = R mod N
      */
-    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( X, &RR ) );
-    MBEDTLS_MPI_CHK( mpi_montred( X, N, mm, &T ) );
+    MBEDTLS_MPI_CHK( mbedtls_mpi_copy( X, &ctx->RR ) );
+    MBEDTLS_MPI_CHK( mpi_montred( X, N, mm, &ctx->T ) );
 
     if( wsize > 1 )
     {
@@ -1690,21 +1699,21 @@ int mbedtls_mpi_exp_mod( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi
          */
         j =  one << ( wsize - 1 );
 
-        MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &W[j], N->n + 1 ) );
-        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &W[j], &W[1]    ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &ctx->W[j], N->n + 1 ) );
+        MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &ctx->W[j], &ctx->W[1]    ) );
 
         for( i = 0; i < wsize - 1; i++ )
-            MBEDTLS_MPI_CHK( mpi_montmul( &W[j], &W[j], N, mm, &T ) );
+            MBEDTLS_MPI_CHK( mpi_montmul( &ctx->W[j], &ctx->W[j], N, mm, &ctx->T ) );
 
         /*
          * W[i] = W[i - 1] * W[1]
          */
         for( i = j + 1; i < ( one << wsize ); i++ )
         {
-            MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &W[i], N->n + 1 ) );
-            MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &W[i], &W[i - 1] ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_grow( &ctx->W[i], N->n + 1 ) );
+            MBEDTLS_MPI_CHK( mbedtls_mpi_copy( &ctx->W[i], &ctx->W[i - 1] ) );
 
-            MBEDTLS_MPI_CHK( mpi_montmul( &W[i], &W[1], N, mm, &T ) );
+            MBEDTLS_MPI_CHK( mpi_montmul( &ctx->W[i], &ctx->W[1], N, mm, &ctx->T ) );
         }
     }
 
@@ -1741,7 +1750,7 @@ int mbedtls_mpi_exp_mod( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi
             /*
              * out of window, square X
              */
-            MBEDTLS_MPI_CHK( mpi_montmul( X, X, N, mm, &T ) );
+            MBEDTLS_MPI_CHK( mpi_montmul( X, X, N, mm, &ctx->T ) );
             continue;
         }
 
@@ -1759,12 +1768,12 @@ int mbedtls_mpi_exp_mod( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi
              * X = X^wsize R^-1 mod N
              */
             for( i = 0; i < wsize; i++ )
-                MBEDTLS_MPI_CHK( mpi_montmul( X, X, N, mm, &T ) );
+                MBEDTLS_MPI_CHK( mpi_montmul( X, X, N, mm, &ctx->T ) );
 
             /*
              * X = X * W[wbits] R^-1 mod N
              */
-            MBEDTLS_MPI_CHK( mpi_montmul( X, &W[wbits], N, mm, &T ) );
+            MBEDTLS_MPI_CHK( mpi_montmul( X, &ctx->W[wbits], N, mm, &ctx->T ) );
 
             state--;
             nbits = 0;
@@ -1777,18 +1786,18 @@ int mbedtls_mpi_exp_mod( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi
      */
     for( i = 0; i < nbits; i++ )
     {
-        MBEDTLS_MPI_CHK( mpi_montmul( X, X, N, mm, &T ) );
+        MBEDTLS_MPI_CHK( mpi_montmul( X, X, N, mm, &ctx->T ) );
 
         wbits <<= 1;
 
         if( ( wbits & ( one << wsize ) ) != 0 )
-            MBEDTLS_MPI_CHK( mpi_montmul( X, &W[1], N, mm, &T ) );
+            MBEDTLS_MPI_CHK( mpi_montmul( X, &ctx->W[1], N, mm, &ctx->T ) );
     }
 
     /*
      * X = A^E * R * R^-1 mod N = A^E mod N
      */
-    MBEDTLS_MPI_CHK( mpi_montred( X, N, mm, &T ) );
+    MBEDTLS_MPI_CHK( mpi_montred( X, N, mm, &ctx->T ) );
 
     if( neg && E->n != 0 && ( E->p[0] & 1 ) != 0 )
     {
@@ -1799,12 +1808,14 @@ int mbedtls_mpi_exp_mod( mbedtls_mpi *X, const mbedtls_mpi *A, const mbedtls_mpi
 cleanup:
 
     for( i = ( one << ( wsize - 1 ) ); i < ( one << wsize ); i++ )
-        mbedtls_mpi_free( &W[i] );
+        mbedtls_mpi_free( &ctx->W[i] );
 
-    mbedtls_mpi_free( &W[1] ); mbedtls_mpi_free( &T ); mbedtls_mpi_free( &Apos );
+    mbedtls_mpi_free( &ctx->W[1] ); mbedtls_mpi_free( &ctx->T ); mbedtls_mpi_free( &ctx->Apos );
 
     if( _RR == NULL || _RR->p == NULL )
-        mbedtls_mpi_free( &RR );
+        mbedtls_mpi_free( &ctx->RR );
+free_ctx:
+    kfree(ctx);
 
     return( ret );
 }
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
