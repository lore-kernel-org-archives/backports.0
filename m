Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35475 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753090AbcKNKqH (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 14 Nov 2016 05:46:07 -0500
Received: by mail-pf0-f173.google.com with SMTP id i88so29157396pfk.2
        for <backports@vger.kernel.org>; Mon, 14 Nov 2016 02:46:06 -0800 (PST)
Subject: Re: min/max mtu field in struct net_device
To: Johannes Berg <johannes@sipsolutions.net>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
References: <c4682854-87ce-5e28-d049-545f24d48cab@broadcom.com>
 <1479115859.7899.3.camel@sipsolutions.net>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <57925560-252e-a547-fe09-959362d9dce4@broadcom.com> (sfid-20161114_114609_899102_0DAAC8DA)
Date: Mon, 14 Nov 2016 11:46:01 +0100
MIME-Version: 1.0
In-Reply-To: <1479115859.7899.3.camel@sipsolutions.net>
Content-Type: multipart/mixed;
 boundary="------------DFA882ACA6FB1769F51BDF68"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a multi-part message in MIME format.
--------------DFA882ACA6FB1769F51BDF68
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 14-11-2016 10:30, Johannes Berg wrote:
> On Mon, 2016-11-14 at 09:49 +0100, Arend Van Spriel wrote:
>> Just wondering. Does anyone have any ideas on how to backport the two
>> patches below. The struct net_device now holds mtu range which
>> network subsystem checks. For a number of drivers and mac80211 it
>> means they no longer have .ndo_change_mtu callback. My guess is that
>> we need patches in backport of some sort to tackle this.
> 
> Yeah, I kinda saw this coming. Since in almost all cases using the new
> min/max the ndo_change_mtu was actually removed, perhaps we can come up
> with a way to spatch it back in?

Me too. This is what I got so far, but the callback is generated twice
for net/mac80211/iface.c for obvious reasons (data and monitor ops).
These are my first baby steps with spatch so not sure how to solve it.

Gr. AvS

--------------DFA882ACA6FB1769F51BDF68
Content-Type: text/plain; charset=UTF-8;
 name="0073-netdevice-mtu-range.cocci"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0073-netdevice-mtu-range.cocci"

QHIxQApleHByZXNzaW9uIG5kZXYsIGUxLCBlMjsKaWRlbnRpZmllciBmdW5jOwpAQApmdW5j
KC4uLikgewoJPC4uLgotIAluZGV2LT5taW5fbXR1ID0gZTE7Ci0gCW5kZXYtPm1heF9tdHUg
PSBlMjsKCS4uLj4KfQpAQApleHByZXNzaW9uIHIxLmUxLCByMS5lMjsKaWRlbnRpZmllciBP
UFM7CkBACisgc3RhdGljIGludCBfX2NoYW5nZV9tdHUoc3RydWN0IG5ldF9kZXZpY2UgKm5k
ZXYsIGludCBuZXdfbXR1KQorIHsKKwlpZiAobmV3X210dSA8IGUxIHx8IG5ld19tdHUgPiBl
MikKKyAJCXJldHVybiAtRUlOVkFMOworCW5kZXYtPm10dSA9IG5ld19tdHU7CisgfQorCnN0
cnVjdCBuZXRfZGV2aWNlX29wcyBPUFMgPSB7CisgCS5uZG9fY2hhbmdlX210dSA9IF9fY2hh
bmdlX210dSwKCS4uLgp9Owo=
--------------DFA882ACA6FB1769F51BDF68--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
