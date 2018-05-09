Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:45717 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934140AbeEIIvq (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 9 May 2018 04:51:46 -0400
Received: by mail-pg0-f53.google.com with SMTP id w3-v6so1843750pgv.12
        for <backports@vger.kernel.org>; Wed, 09 May 2018 01:51:46 -0700 (PDT)
Subject: Re: Failed to backport from from Linux 4.4 drivers to Linux 3.10.108
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <149bc44e-f521-cf4a-397a-c8e42d00081b@gmail.com>
 <1525770549.14830.1.camel@sipsolutions.net>
 <a6942432-8895-fa56-5a37-a232b99c38fc@gmail.com>
 <1525770503.14830.2.camel@sipsolutions.net>
 <2e85d2c4-d89e-6ab0-2b8e-60ce683f477f@gmail.com>
 <b67c4791-f0da-0fe0-c787-85e9a7824bc6@gmail.com>
 <1525850665.6910.0.camel@sipsolutions.net>
 <1525852495.6910.2.camel@sipsolutions.net>
 <2f59e893-da45-f3e7-430b-1377518727bb@gmail.com>
 <1525853548.6910.3.camel@sipsolutions.net>
From: Masashi Honma <masashi.honma@gmail.com>
Message-ID: <d54cd7c5-fb33-59dc-afd0-d48f36a7a06d@gmail.com> (sfid-20180509_105150_311982_21C3ADDF)
Date: Wed, 9 May 2018 17:51:36 +0900
MIME-Version: 1.0
In-Reply-To: <1525853548.6910.3.camel@sipsolutions.net>
Content-Type: multipart/mixed;
 boundary="------------40254726DE30790B509F47D4"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a multi-part message in MIME format.
--------------40254726DE30790B509F47D4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2018/05/09 17:12, Johannes Berg wrote:
> Though of course this doesn't apply to the older branches :)

How about setting upper limitation to the older branches by attached patch ?

Masashi Honma.

--------------40254726DE30790B509F47D4
Content-Type: text/plain; charset=UTF-8;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch"

ZGlmZiAtLWdpdCBhL2xpYi9icHJlcXMucHkgYi9saWIvYnByZXFzLnB5CmluZGV4IDEzMjVm
ZDIuLmZlZWY0NDQgMTAwNjQ0Ci0tLSBhL2xpYi9icHJlcXMucHkKKysrIGIvbGliL2JwcmVx
cy5weQpAQCAtMTkwLDEwICsxOTAsMTEgQEAgY2xhc3MgUmVxOgogICAgICAgICBzeXMuc3Rk
b3V0LndyaXRlKCJUcnkgaW5zdGFsbGluZyB0aGUgcGFja2FnZTogJXNcbiIgJSBwYWNrYWdl
X2hpbnQpCiAgICAgICAgIHJldHVybiBGYWxzZQogICAgIGRlZiBjb2NjaW5lbGxlKHNlbGYs
IHZlcnNpb24pOgotICAgICAgICBpZiBzZWxmLnJlcXVpcmVfdmVyc2lvbignc3BhdGNoJywg
Jy0tdmVyc2lvbicsIHZlcnNpb24sIDIsIHNlbGYubGludXhfdmVyc2lvbl9jbXApOgorICAg
ICAgICBpZiBzZWxmLmxpbnV4X3ZlcnNpb25fY21wKCcxLjAuNicsIHNlbGYucmVxX2dldF9w
cm9nX3ZlcnNpb24oJ3NwYXRjaCcsICctLXZlcnNpb24nLCAyKSkgPT0gLTEgYW5kIFwKKyAg
ICAgICAgICAgc2VsZi5yZXF1aXJlX3ZlcnNpb24oJ3NwYXRjaCcsICctLXZlcnNpb24nLCB2
ZXJzaW9uLCAyLCBzZWxmLmxpbnV4X3ZlcnNpb25fY21wKToKICAgICAgICAgICAgIHJldHVy
biBUcnVlCiAgICAgICAgIHN5cy5zdGRvdXQud3JpdGUoIlRyeSBpbnN0YWxsaW5nIHRoZSBw
YWNrYWdlOiBjb2NjaW5lbGxlXG4iKQotICAgICAgICBzeXMuc3Rkb3V0LndyaXRlKCJJZiB0
aGF0IGlzIHRvbyBvbGQgZ28gZ3JhYiB0aGUgY29kZSBmcm9tIHNvdXJjZTpcblxuIikKKyAg
ICAgICAgc3lzLnN0ZG91dC53cml0ZSgiSWYgdGhhdCBpcyBsZXNzIHRoYW4gIiArIHZlcnNp
b24gKyAiIG9yIG1vcmUgdGhhbiAxLjAuNiBnbyBncmFiIHRoZSBjb2RlIGZyb20gc291cmNl
OlxuXG4iKQogICAgICAgICBzeXMuc3Rkb3V0LndyaXRlKCJnaXQgY2xvbmUgaHR0cHM6Ly9n
aXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS5naXRcblxuIikKICAgICAgICAgc3lz
LnN0ZG91dC53cml0ZSgiVG8gYnVpbGQgeW91IHdpbGwgbmVlZDogb2NhbWwgbmN1cnNlcy1k
ZXZlbFxuXG4iKQogICAgICAgICBzeXMuc3Rkb3V0LndyaXRlKCJJZiBvbiBTVVNFIC8gT3Bl
blNVU0UgeW91IHdpbGwgYWxzbyBuZWVkOiBvY2FtbC1vY2FtbGRvY1xuXG4iKQo=
--------------40254726DE30790B509F47D4--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
