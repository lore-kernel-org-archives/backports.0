Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1.esolutions.de ([178.239.73.50]:13143 "EHLO
        mail-gw1.esolutions.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbcKRLtk (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 18 Nov 2016 06:49:40 -0500
Received: from DEGAMES01.eso.local (degames01.eso.local [10.2.0.245])
        by mail-gw1.esolutions.de (Postfix) with ESMTPS
        for <backports@vger.kernel.org>; Fri, 18 Nov 2016 12:49:37 +0100 (CET)
From: Gienger Timo <Timo.Gienger@esolutions.de>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Kernel integrated backports ends in endless silentoldconfig
 loop when built out of tree
Date: Fri, 18 Nov 2016 11:49:36 +0000
Message-ID: <DFF58FB81DEAB64EB0833EEE3623AE53AB6080F4@DEGAMES02.eso.local> (sfid-20161118_124942_511160_2CF1BC44)
References: <DFF58FB81DEAB64EB0833EEE3623AE53AB604CDD@DEGAMES02.eso.local>
 <DFF58FB81DEAB64EB0833EEE3623AE53AB607D0B@DEGAMES02.eso.local>
 <DFF58FB81DEAB64EB0833EEE3623AE53AB60806F@DEGAMES02.eso.local>
In-Reply-To: <DFF58FB81DEAB64EB0833EEE3623AE53AB60806F@DEGAMES02.eso.local>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

T24gRnJpLCAyMDE2LTExLTE4IGF0IDExOjAxICswMDAwLCBHaWVuZ2VyIFRpbW8gd3JvdGU6Cj4g
SGVyZSBpdCBzZWVtcyB0aGF0IHRoZSBhY3R1YWwgcHJvYmxlbSBpcyB0aGUgdmFyaWFibGUgc3Vi
c3RpdHV0aW9uLAo+IGFmdGVyIGNoYW5naW5nOgo+IC1zb3VyY2UgIiRCQUNLUE9SVF9ESVIvS2Nv
bmZpZy52ZXJzaW9ucyIKPiAtc291cmNlICIkQkFDS1BPUlRfRElSL0tjb25maWcuc291cmNlcyIK
PiB0bwo+ICtzb3VyY2UgImJhY2twb3J0cy9LY29uZmlnLnZlcnNpb25zIgo+ICtzb3VyY2UgImJh
Y2twb3J0cy9LY29uZmlnLnNvdXJjZXMiCj4gdGhlIG1ha2Ugc3lzdGVtIGlzIGFibGUgdG8gZmlu
ZCB0aGUgdGFyZ2V0cyBhbmQgaXMgYWJsZSB0byBidWlsZCBvdXQgb2YKPiB0cmVlLiBTbyB0byB0
aGUgdGltZSB0aGUgMiBmaWxlcyBhcmUgc291cmNlZCBCQUNLUE9SVF9ESVIgaXMgbm90IHlldAo+
IGRlZmluZWQgYXQgZmFpbHMgYmVjYXVzZSBvZiB0aGlzLgoKQWN0dWFsbHkgaXQgaXMgZGVmaW5l
ZCBhcyB0aGUgc3RyYWNlIHNob3dzOgoyNTgzOSBzdGF0KCJiYWNrcG9ydHMvL0tjb25maWcuc291
cmNlcyIsIDB4N2ZmY2FmNmZmOWUwKSA9IC0xIEVOT0VOVCAoTm8Kc3VjaCBmaWxlIG9yIGRpcmVj
dG9yeSkKMjU4Mzkgc3RhdCgiL3NzZDEvbGludXgtdGFyZ2V0L2JhY2twb3J0cy8vY29uZmlnLnNv
dXJjZXMiLAoweDdmZmNhZjcwMTliMCkgPSAtMSBFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJl
Y3RvcnkpCjI1ODM5IHN0YXQoImJhY2twb3J0cy8vS2NvbmZpZy52ZXJzaW9ucyIsIDB4N2ZmY2Fm
NmZmYTUwKSA9IC0xIEVOT0VOVAooTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkKMjU4Mzkgc3Rh
dCgiL3NzZDEvbGludXgtdGFyZ2V0L2JhY2twb3J0cy8vY29uZmlnLnZlcnNpb25zIiwKMHg3ZmZj
YWY3MDFhMjApID0gLTEgRU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQoKQnV0IHNl
ZW1zIHRvIGdldCBtZXNzZWQgdXAgc29tZXdoZXJlIGJlY2F1c2Ugb2YgdGhhdC4KCg==
--
To unsubscribe from this list: send the line "unsubscribe backports" in
