Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E34C433EF
	for <backports@archiver.kernel.org>; Tue,  8 Feb 2022 07:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbiBHH6o (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 8 Feb 2022 02:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiBHH6o (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 8 Feb 2022 02:58:44 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FBCC0401EF
        for <backports@vger.kernel.org>; Mon,  7 Feb 2022 23:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=zkC0OQWFtDDf7asIJRJn128DqzXSgwhlk9gBeOGCgJo=;
        t=1644307123; x=1645516723; b=Z3lUco2iouwl7iJqQ2cHaIGiFcM18rYMgsOfiHn6mFccULs
        F4c4TykVq8o4Wp9nr7+OyJBYRaQBKZHWdeVILwv6hENoxC4bvflGOrT//XPdVLv/2SsCNJqc/cf7/
        AxIwOCou09BUNDsd3W5NA1fJ0Qk6hcnxPq6WLmfS/5fNUVtaCCD+ACMeQhevLEKzE/JNPORVr4AZ+
        SLhe0KkxQBd5c0+sJUILruDC7HrSfe/2OvzZYhVH3dPNQVAf56tm4h5i3YyuJTQQopU9qgxW3N8BE
        WGOMvEeHOoYBfIsLoXTv0ovHZFRhof0TyYJz5fLMV/a28+KLHm1grfvQFy3FoU0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nHLOX-00Fx9o-Mx;
        Tue, 08 Feb 2022 08:58:37 +0100
Message-ID: <1ac779ab0dfebdaa1ce7e5b6e900d49164e4afa9.camel@sipsolutions.net>
Subject: Re: Dealing with SUBLEVEL overflow in backports
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        backports@vger.kernel.org
Date:   Tue, 08 Feb 2022 08:58:36 +0100
In-Reply-To: <9886de4b-7e5c-ee34-6e2c-83efb358d1ac@hauke-m.de>
References: <1796985a-4524-f6f8-2f67-acb2e985e87f@flygoat.com>
         <545f9eb36509c21b3217804b43da4dcdbaf623b1.camel@sipsolutions.net>
         <b372254d9c4cc7156eabfb5dd722d02541a31ea1.camel@sipsolutions.net>
         <cf1d0098-f871-4086-18fd-ffbc8e90da66@flygoat.com>
         <bb0ae37aa770e016463706d557fec1c5205bc6a9.camel@sipsolutions.net>
         <5a58d473-a0a1-b213-c71d-963e6b180593@flygoat.com>
         <d29fa260e1e9d43dc3fa2f5b9683a5b336451ad8.camel@sipsolutions.net>
         <b16e61de-9258-7f32-7c2c-d59565f5fd05@flygoat.com>
         <f234795fbc9ba700982d5182f3cb71d5a0408c17.camel@sipsolutions.net>
         <9886de4b-7e5c-ee34-6e2c-83efb358d1ac@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2022-02-07 at 23:18 +0100, Hauke Mehrtens wrote:
> 
> The LINUX_VERSION_CODE is fixed since 4.9.255, see here:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=42efb098c75f9d4b95f7cf35d3d52e80cc2fde82
> 
> SUBLEVEL should still contains the minor kernel version number.
> 
> We could extend the macros in backport/backport-include/linux/version.h 
> to check for SUBLEVEL manually if it overflows.
> 

Right, but the thing is we don't have SUBLEVEL in the *C* code, only in
the Makefile.

However, stupid me? This is trivial:

--- a/Makefile.kernel
+++ b/Makefile.kernel
@@ -60,3 +60,5 @@ obj-$(CPTCFG_WLAN) += drivers/net/wireless/
 #obj-$(CPTCFG_USB_USBNET) += drivers/net/usb/
 #
 #obj-$(CPTCFG_STAGING) += drivers/staging/
+
+subdir-ccflags-y += -DCOMPAT_KERNEL_SUBLEVEL=$(SUBLEVEL)


(whatever the name is)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
