Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <andy@greyhouse.net>
Date: Fri, 1 Mar 2013 14:56:17 -0500
From: Andy Gospodarek <andy@greyhouse.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: Gorlevich Vladislav <Vladislav.Gorlevich@renlife.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "unified-drivers@lists.infradead.org" <unified-drivers@lists.infradead.org>,
        backports@vger.kernel.org
Subject: Re: QCA alx Ethernet driver
Message-ID: <20130301195617.GM22668@gospo.rdu.redhat.com>
References: <CAB=NE6UVcok33umedje3AuqJNK51QTMFeVjeZxr7jvEosLi==g@mail.gmail.com>
 <0891E9AFF5C074489DA21F93F868F98787CCCB2C9B@colorado>
 <CAB=NE6VuvHbYnjR7KyEwo56CkfsHrbwetoz9+0sapnx9cPefMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAB=NE6VuvHbYnjR7KyEwo56CkfsHrbwetoz9+0sapnx9cPefMw@mail.gmail.com>
List-ID: <backports@vger.kernel.org>

On Fri, Mar 01, 2013 at 11:27:46AM -0800, Luis R. Rodriguez wrote:
> On Thu, Feb 28, 2013 at 8:03 PM, Gorlevich Vladislav
> <Vladislav.Gorlevich@renlife.com> wrote:
> > Error still remains:
> >
> > make
> > ./scripts/gen-compat-autoconf.sh /root/compat-drivers-2013-02-27-u/.config /root/compat-drivers-2013-02-27-u/config.mk > include/linux/compat_autoconf.h
> > make -C /lib/modules/2.6.32-300.39.4.el5uek/build M=/root/compat-drivers-2013-02-27-u modules
> 
> 2.6.32-300.39.4.el5uek seems to be a kernel part of Oracle Linux 5.
> That is, it is not a vanilla Linux kernel and we only test building
> compat-drivers on vanilla kernels. If a Linux distribution chooses to
> muck with their own old kernel then support for that kernel can be
> added but it must be done as was done for SUSE and RHEL.
> 
> That is, if you want to support Oracle Linux 5 you will have to add
> support yourself or get someone at Oracle to jump in and contribute
> just as was done for SUSE and RHEL.
> 
> > make[1]: Entering directory `/usr/src/kernels/2.6.32-300.39.4.el5uek'
> >   CC [M]  /root/compat-drivers-2013-02-27-u/compat/main.o
> > In file included from /root/compat-drivers-2013-02-27-u/include/linux/compat-2.6.h:58,
> >                  from <command line>:1:
> > /root/compat-drivers-2013-02-27-u/include/linux/compat-2.6.35.h:49: error: conflicting types for вnetif_set_real_num_tx_queuesв
> > include/linux/netdevice.h:1572: error: previous declaration of вnetif_set_real_num_tx_queuesв was here
> > make[3]: *** [/root/compat-drivers-2013-02-27-u/compat/main.o] Error 1
> > make[2]: *** [/root/compat-drivers-2013-02-27-u/compat] Error 2
> > make[1]: *** [_module_/root/compat-drivers-2013-02-27-u] Error 2
> > make[1]: Leaving directory `/usr/src/kernels/2.6.32-300.39.4.el5uek'
> > make: *** [modules] Error 2
> 
> That should be easy to fix but again, I personally only support
> testing against vanilla kernels.
> 

If you want to follow the precedent that currently exists in compat, I
would suggest grabbing the compat.git sources[0] and putting together a
patch that looks similar to what was done for RHEL support of compat
since the situation is *ahem* similar to what is done with OEL.

You can follow the patch below[1] as a guide.  This small part of the
larger patch deals with the inclusion of ewma_init and ewma_add that is
almost identical your current situation.

Feel free to email me or write back to the list if you have any issues.

0.  git://github.com/mcgrof/compat.git

1.  $ git show 0026e404500f924114ea2d352a06a3713a84ea61 include/linux/compat-2.6.38.h compat/compat-2.6.38.c
commit 0026e404500f924114ea2d352a06a3713a84ea61
Author: Andy Gospodarek <andy@greyhouse.net>
Date:   Thu Aug 9 00:40:15 2012 -0400

    compat: support RHEL6.3 as a build target
    
    This patch allows me to compile and load the latest compat modules on
    RHEL6.3.  Users of compat on RHEL6 should note that you should set
    CONFIG_COMPAT_KFIFO=n as those bits are not needed at all.
    
    These changes seem to pass built-in tests on my system:
    
    # ./bin/ckmake
    Trying kernel 3.5.0-030500-generic [OK]
    Trying kernel 3.4.4-030404-generic [OK]
    Trying kernel 3.3.7-030307-generic [OK]
    Trying kernel 3.2.2-030202-generic [OK]
    Trying kernel 3.1.10-030110-generic [OK]
    Trying kernel 3.0.18-030018-generic [OK]
    Trying kernel 2.6.39-02063904-generic [OK]
    Trying kernel 2.6.38-02063808-generic [OK]
    Trying kernel 2.6.37-02063706-generic [OK]
    Trying kernel 2.6.36-02063604-generic [OK]
    Trying kernel 2.6.35-02063512-generic [OK]
    Trying kernel 2.6.34-02063410-generic [OK]
    Trying kernel 2.6.33-02063305-generic [OK]
    Trying kernel 2.6.32-02063255-generic [OK]
    Trying kernel 2.6.31-02063113-generic [OK]
    Trying kernel 2.6.30-02063010-generic [OK]
    Trying kernel 2.6.29-02062906-generic [OK]
    Trying kernel 2.6.28-02062810-generic [OK]
    Trying kernel 2.6.27-020627-generic [OK]
    Trying kernel 2.6.26-020626-generic [OK]
    Trying kernel 2.6.25-020625-generic [OK]
    Trying kernel 2.6.24-020624-generic [OK]
    
    Signed-off-by: Andy Gospodarek <andy@greyhouse.net>
    Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>

diff --git a/compat/compat-2.6.38.c b/compat/compat-2.6.38.c
index 0074ac6..b546194 100644
--- a/compat/compat-2.6.38.c
+++ b/compat/compat-2.6.38.c
@@ -22,14 +22,14 @@
  *
  * Initialize the EWMA parameters for a given struct ewma @avg.
  */
-void ewma_init(struct ewma *avg, unsigned long factor, unsigned long weight)
+void compat_ewma_init(struct ewma *avg, unsigned long factor, unsigned long weight)
 {
 	WARN_ON(weight <= 1 || factor == 0);
 	avg->internal = 0;
 	avg->weight = weight;
 	avg->factor = factor;
 }
-EXPORT_SYMBOL_GPL(ewma_init);
+EXPORT_SYMBOL_GPL(compat_ewma_init);
 
 /**
  * ewma_add() - Exponentially weighted moving average (EWMA)
@@ -38,7 +38,7 @@ EXPORT_SYMBOL_GPL(ewma_init);
  *
  * Add a sample to the average.
  */
-struct ewma *ewma_add(struct ewma *avg, unsigned long val)
+struct ewma *compat_ewma_add(struct ewma *avg, unsigned long val)
 {
 	avg->internal = avg->internal  ?
 		(((avg->internal * (avg->weight - 1)) +
@@ -46,5 +46,5 @@ struct ewma *ewma_add(struct ewma *avg, unsigned long val)
 		(val * avg->factor);
 	return avg;
 }
-EXPORT_SYMBOL_GPL(ewma_add);
+EXPORT_SYMBOL_GPL(compat_ewma_add);
 
diff --git a/include/linux/compat-2.6.38.h b/include/linux/compat-2.6.38.h
index 0a86468..1d72523 100644
--- a/include/linux/compat-2.6.38.h
+++ b/include/linux/compat-2.6.38.h
@@ -55,9 +55,15 @@ struct ewma {
 	unsigned long weight;
 };
 
+/* mask ewma_init as RHEL6 backports this */
+#define ewma_init(a,b,c) compat_ewma_init(a,b,c)
+
 extern void ewma_init(struct ewma *avg, unsigned long factor,
 		      unsigned long weight);
 
+/* mask ewma_add as RHEL6 backports this */
+#define ewma_add(a,b) compat_ewma_add(a,b)
+
 extern struct ewma *ewma_add(struct ewma *avg, unsigned long val);
 
 /**
