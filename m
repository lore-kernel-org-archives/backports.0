Return-path: <backports-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:27532 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373AbbHaO0b (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 31 Aug 2015 10:26:31 -0400
Subject: Re: newbie questions
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <55E3A03D.6050607@linux.intel.com>
 (sfid-20150831_023101_616135_D37C8DBB)
 <1441006988.13980.3.camel@sipsolutions.net>
 <55E44DA7.3000209@linux.intel.com>
 <1441025664.13980.8.camel@sipsolutions.net>
 <55E454C9.5070302@linux.intel.com>
 <1441028012.13980.10.camel@sipsolutions.net>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <55E46415.9040003@linux.intel.com> (sfid-20150831_162633_470862_055E1830)
Date: Mon, 31 Aug 2015 09:26:29 -0500
MIME-Version: 1.0
In-Reply-To: <1441028012.13980.10.camel@sipsolutions.net>
Content-Type: multipart/mixed;
 boundary="------------080201010601070701060505"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080201010601070701060505
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 08/31/2015 08:33 AM, Johannes Berg wrote:
> On Mon, 2015-08-31 at 08:21 -0500, Pierre-Louis Bossart wrote:
>>>
>>> The *to* version is never relevant. A given backport will compile
>>> against many different *to* versions.
>>
>> I guess I completely missed the concept. I was thinking that the 
>> gentree.py command would only port and adjust the delta between linux
>> -next and the version I wanted. Looks like the backport is really an 
>> add-on that will apply to multiple versions. Not sure I understand 
>> how successive changes in the tree are handled if there is a single 
>> backport.
> 
> Well, there's a single *from* version, as you say that was currently
> "next-20150731" (or that was the one you used). The backport git
> repository is maintained in lockstep with the *from* version (although
> there's usually quite a bit of wiggle room)
> 
> The result, the output of backports, will/should compile against any
> kernel starting from the earliest supported, all the way up to the
> *from* version, right now I think that's 3.0 until 4.1 or so. 

What I was really looking for is the --integrate option that does merge the backport into an existing tree.
This option is broken btw on newer kernels due to a change in the kernel Makefile in October 2014, the attached patch provides a correction (not sure how to use the right patch for the right kernel though).
-Pierre


--------------080201010601070701060505
Content-Type: text/x-patch;
 name="0001-enable-backports-built-in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-enable-backports-built-in.patch"

Allow backports to be integrated into vmlinux with newer Makefiles

diff --git a/Makefile b/Makefile
index f5c8983..31c7cbf 100644
--- a/Makefile
+++ b/Makefile
@@ -555,6 +555,7 @@ scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
 	$(Q)$(MAKE) $(build)=$(@)
 
 # Objects we will link into vmlinux / subdirs we need to visit
+backports-y 	:= backports/
 init-y		:= init/
 drivers-y	:= drivers/ sound/ firmware/
 net-y		:= net/
@@ -887,11 +888,13 @@ core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
 
 vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
+		     $(backports-y) $(backports-m) \
 		     $(net-y) $(net-m) $(libs-y) $(libs-m)))
 
 vmlinux-alldirs	:= $(sort $(vmlinux-dirs) $(patsubst %/,%,$(filter %/, \
-		     $(init-) $(core-) $(drivers-) $(net-) $(libs-))))
+		     $(init-) $(core-) $(drivers-) $(backports-) $(net-) $(libs-))))
 
+backports-y	:= $(patsubst %/, %/built-in.o, $(backports-y))
 init-y		:= $(patsubst %/, %/built-in.o, $(init-y))
 core-y		:= $(patsubst %/, %/built-in.o, $(core-y))
 drivers-y	:= $(patsubst %/, %/built-in.o, $(drivers-y))
@@ -902,7 +905,7 @@ libs-y		:= $(libs-y1) $(libs-y2)
 
 # Externally visible symbols (used by link-vmlinux.sh)
 export KBUILD_VMLINUX_INIT := $(head-y) $(init-y)
-export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y)
+export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y) $(backports-y)
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
 export LDFLAGS_vmlinux
 # used by scripts/pacmage/Makefile

--------------080201010601070701060505--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
