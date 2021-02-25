Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58E4C43381
	for <backports@archiver.kernel.org>; Thu, 25 Feb 2021 08:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E1364E4D
	for <backports@archiver.kernel.org>; Thu, 25 Feb 2021 08:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhBYInS (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 25 Feb 2021 03:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbhBYInO (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 25 Feb 2021 03:43:14 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5D4C06174A
        for <backports@vger.kernel.org>; Thu, 25 Feb 2021 00:42:33 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lFCEB-008Mfc-7g; Thu, 25 Feb 2021 09:42:31 +0100
Message-ID: <1aae3fb1963fc525a587dbef7317ebc0fd988f0f.camel@sipsolutions.net>
Subject: Re: backports Kconfig processing
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     backports@vger.kernel.org
Date:   Thu, 25 Feb 2021 09:42:30 +0100
In-Reply-To: <842e7a1b-8a48-a6d0-3fe4-ca76b85e6218@broadcom.com> (sfid-20210225_093145_502488_3F13B01B)
References: <a3926220-cc2c-5feb-0017-bf8793184cea@broadcom.com>
         <0dfe67b7019ec7971244d5e2813f9b6c1a558524.camel@sipsolutions.net>
         <842e7a1b-8a48-a6d0-3fe4-ca76b85e6218@broadcom.com>
         (sfid-20210225_093145_502488_3F13B01B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Thu, 2021-02-25 at 09:31 +0100, Arend van Spriel wrote:
> 
> On 24-02-2021 15:32, Johannes Berg wrote:
> > Hi Arend,
> > 
> > > I was made aware that the select line in brcm80211 Kconfig is not
> > > working in backports:
> > > 
> > > select WANT_DEV_COREDUMP if BRCMFMAC
> > > 
> > > Is this something that can be fixed in backports?
> > 
> > I guess it can be, but what do you mean by "not working"?
> > 
> > It should be rewritten to
> > 
> > select BPAUTO_WANT_DEV_COREDUMP if BRCMFMAC
> > 
> > but quite possibly the parser doesn't understand the " if BRCMFMAC" part
> > there.
> 
> That exactly what is being reported. Things were working fine until I 
> added the "if BRCMFMAC" part.

Yeah, so lib/kconfig.py has this

sel_line = re.compile(r'^(?P<spc>\s+)select\s+(?P<sym>[^\s]*)\s*$')

which doesn't cover the case of "if ..." on the select line.

I guess you could either look at that and fix it - need to fix the regex
to allow all_selects() to find it, and modify_selects() to preserve the
"if ..." part.

Probably something like

diff --git a/lib/kconfig.py b/lib/kconfig.py
index a77f8a54eea7..46df636d7594 100644
--- a/lib/kconfig.py
+++ b/lib/kconfig.py
@@ -8,7 +8,7 @@ src_line_rel = re.compile(r'^\s*source\s+(?P<src>[^\s"]*)"?\s*$')
 tri_line = re.compile(r'^(?P<spc>\s+)tristate')
 bool_line = re.compile(r'^(?P<spc>\s+)bool')
 cfg_line = re.compile(r'^(?P<opt>config|menuconfig)\s+(?P<sym>[^\s]*)')
-sel_line = re.compile(r'^(?P<spc>\s+)select\s+(?P<sym>[^\s]*)\s*$')
+sel_line = re.compile(r'^(?P<spc>\s+)select\s+(?P<sym>[^\s]*)(?P<ifexpr>.*)$')
 backport_line = re.compile(r'^\s+#(?P<key>[ch]-file|module-name)\s*(?P<name>.*)')
 
 class ConfigTree(object):
@@ -230,9 +230,9 @@ class ConfigTree(object):
                 m = sel_line.match(l)
                 if m and not m.group('sym') in syms:
                     if 'BPAUTO_' + m.group('sym') in syms:
-                        out += m.group('spc') + "select BPAUTO_" + m.group('sym') + '\n'
+                        out += m.group('spc') + "select BPAUTO_" + m.group('sym') + m.group('ifexpr') + '\n'
                     else:
-                        out += m.group('spc') + "depends on " + m.group('sym') + '\n'
+                        out += m.group('spc') + "depends on " + m.group('sym') + m.group('ifexpr') + '\n'
                 else:
                     out += l
             outf = open(os.path.join(self.bpid.target_dir, nf), 'w')


johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
