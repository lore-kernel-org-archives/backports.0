Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:35093 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163AbbIIMDs (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 9 Sep 2015 08:03:48 -0400
Message-ID: <55F02021.3060603@broadcom.com> (sfid-20150909_140351_831326_EE73A9B7)
Date: Wed, 9 Sep 2015 14:03:45 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: backport devcoredump
References: <55EFEEF2.2060205@broadcom.com> <1441788585.3316.2.camel@sipsolutions.net>
In-Reply-To: <1441788585.3316.2.camel@sipsolutions.net>
Content-Type: multipart/mixed;
	boundary="------------080506050200040309030907"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

--------------080506050200040309030907
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 09/09/2015 10:49 AM, Johannes Berg wrote:
> On Wed, 2015-09-09 at 10:33 +0200, Arend van Spriel wrote:
>> Hi Johannes,
>>
>> I noticed that devcoredump has been added to backports project
>> through
>> backport-adjustment patch. brcmfmac now select WANT_DEV_COREDUMP.
>> However, when I run gentree.py the devcoredump patch is not applied.
>> Also Kconfig of brcm80211 still shows WANT_DEV_COREDUMP.
>
> That's strange.
>
> I guess I'll need to run that - are you using a special copy-list?

I do and maybe that is causing it. I attached it.

Gr. AvS


--------------080506050200040309030907
Content-Type: text/plain; charset="UTF-8"; name="copy-list"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="copy-list"

IwojIFRoaXMgZmlsZSBzcGVjaWZpZXMgd2hpY2ggc291cmNlcyBhcmUgY29waWVkIGZyb20g
dGhlIGtlcm5lbAojIGludG8gdGhlIGJhY2twb3J0cyBwYWNrYWdlLgojCiMgRGlyZWN0b3Jp
ZXMgbXVzdCBlbmQgd2l0aCBhIHNsYXNoIChlLmcuICJuZXQvd2lyZWxlc3MvIikgYW5kCiMg
YXJlIHRoZW4gY29waWVkIHdpdGggYWxsIHRoZWlyIGNvbnRlbnRzLgojCiMgSXQgaXMgYWxz
byBwb3NzaWJsZSB0byByZW5hbWUgd2hpbGUgY29weWluZywgdG8gZG8gc28gbGlzdAojIG9s
ZCBuYW1lIC0+IG5ldyBuYW1lCiMgTm90ZSB0aGF0IGluIHRoaXMgY2FzZSB0aGUgc3BhY2Vz
IGFyZSBuZWVkZWQ6ICIgLT4gIgojCgpDT1BZSU5HCk1BSU5UQUlORVJTCmluY2x1ZGUvbGlu
dXgvdW5hbGlnbmVkLwppbmNsdWRlL2xpbnV4L2hhc2h0YWJsZS5oCgojIDgwMi4xMQpkcml2
ZXJzL25ldC93aXJlbGVzcy9LY29uZmlnCmRyaXZlcnMvbmV0L3dpcmVsZXNzL01ha2VmaWxl
CgppbmNsdWRlL2xpbnV4L3dpcmVsZXNzLmgKaW5jbHVkZS91YXBpL2xpbnV4L3dpcmVsZXNz
LmgKaW5jbHVkZS9saW51eC9pZWVlODAyMTEuaAppbmNsdWRlL2xpbnV4L3BjaV9pZHMuaApp
bmNsdWRlL3VhcGkvbGludXgvcGNpX3JlZ3MuaAppbmNsdWRlL2xpbnV4L21tYy9zZGlvX2lk
cy5oCmluY2x1ZGUvbGludXgvYXRoOWtfcGxhdGZvcm0uaAppbmNsdWRlL3VhcGkvbGludXgv
d2lsNjIxMF91YXBpLmgKaW5jbHVkZS9saW51eC93bDEyeHguaAppbmNsdWRlL2xpbnV4L3Ju
ZGlzLmgKaW5jbHVkZS9saW51eC9iY200N3h4X3dkdC5oCmluY2x1ZGUvbGludXgvdXNiL3Vz
Ym5ldC5oCmluY2x1ZGUvbGludXgvdXNiL3JuZGlzX2hvc3QuaAppbmNsdWRlL2xpbnV4L3Nw
aS9saWJlcnRhc19zcGkuaAppbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvYnJjbWZtYWMt
c2Rpby5oCmluY2x1ZGUvdWFwaS9saW51eC9ubDgwMjExLmgKCmluY2x1ZGUvbmV0L2NmZzgw
MjExLmgKaW5jbHVkZS9uZXQvY2ZnODAyMTEtd2V4dC5oCmluY2x1ZGUvbmV0L2llZWU4MDIx
MV9yYWRpb3RhcC5oCmluY2x1ZGUvbmV0L2xpYjgwMjExLmgKaW5jbHVkZS9uZXQvbWFjODAy
MTEuaAppbmNsdWRlL25ldC9yZWd1bGF0b3J5LmgKCm5ldC9NYWtlZmlsZQpuZXQvS2NvbmZp
ZwpuZXQvd2lyZWxlc3MvCm5ldC9tYWM4MDIxMS8KCmluY2x1ZGUvbGludXgvc3NiLwpkcml2
ZXJzL2JjbWEvCmluY2x1ZGUvbGludXgvYmNtYS8KaW5jbHVkZS9saW51eC9iY200N3h4X252
cmFtLmgKZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJjbTgwMjExLwoKaW5jbHVkZS9uZXQvbmV0
bnMvaWVlZTgwMjE1NF82bG93cGFuLmgKCiMgTVBMUyBsYWJlbHMsIGNoZWNrZWQgb24gc2ti
LT5wcm90b2NvbCBvbiB0aGUKIyByZXNwZWN0aXZlIDgwMiBmYW1pbHksIG9ubHkgZXRoZXJu
ZXQgc2VlbXMgdG8gdXNlCiMgdGhpcyByaWdodCBub3csIHNlZSA5NjBkOTdmOTUKaW5jbHVk
ZS9saW51eC9tcGxzLmgKaW5jbHVkZS91YXBpL2xpbnV4L21wbHMuaAo=
--------------080506050200040309030907--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
