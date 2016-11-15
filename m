Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:32822 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941318AbcKOIgy (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 15 Nov 2016 03:36:54 -0500
Received: by mail-qk0-f175.google.com with SMTP id x190so126940111qkb.0
        for <backports@vger.kernel.org>; Tue, 15 Nov 2016 00:36:54 -0800 (PST)
Subject: Fwd: Re: min/max mtu field in struct net_device
References: <57925560-252e-a547-fe09-959362d9dce4@broadcom.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <3a964780-2513-624f-6a2a-ae507398b0a8@broadcom.com> (sfid-20161115_093657_238164_6A17E176)
Date: Tue, 15 Nov 2016 09:36:50 +0100
MIME-Version: 1.0
In-Reply-To: <57925560-252e-a547-fe09-959362d9dce4@broadcom.com>
Content-Type: multipart/mixed;
 boundary="------------55EC4CA826B6AFDFCD856CD3"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a multi-part message in MIME format.
--------------55EC4CA826B6AFDFCD856CD3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Julia,

Would you have any ideas on how to solve the problem below. The problem
occurs with source files that have more than one struct net_device_ops
defined, which is the case for net/mac80211/iface.c for one. Obviously I
want the callback definition to be added only once.

Regards,
Arend

-------- Forwarded Message --------
Subject: Re: min/max mtu field in struct net_device
Date: Mon, 14 Nov 2016 11:46:01 +0100
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>, backports@vger.kernel.org
<backports@vger.kernel.org>

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


--------------55EC4CA826B6AFDFCD856CD3
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
--------------55EC4CA826B6AFDFCD856CD3--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
