Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34252 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756752AbdAJLQZ (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 10 Jan 2017 06:16:25 -0500
Received: by mail-qk0-f181.google.com with SMTP id a20so171347672qkc.1
        for <backports@vger.kernel.org>; Tue, 10 Jan 2017 03:16:20 -0800 (PST)
Received: from [10.177.251.201] ([80.82.130.242])
        by smtp.gmail.com with ESMTPSA id j9sm1140420qtc.23.2017.01.10.03.16.18
        for <backports@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 03:16:18 -0800 (PST)
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: issue with devcoredump.patch
Message-ID: <118eb454-703f-9de9-6fc4-5326de6592ca@broadcom.com> (sfid-20170110_121630_795348_B55C173D)
Date: Tue, 10 Jan 2017 12:16:17 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------6E5B80DE2D64586D36D5922D"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a multi-part message in MIME format.
--------------6E5B80DE2D64586D36D5922D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

With 4.10-rc1 the devcoredump.patch in patches/backport-adjustment no
longer applies due to following commit:

commit f76d25275c314defb684fdd692239507001774bc
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon Nov 28 16:41:58 2016 +0100

    driver core: devcoredump: convert to use class_groups

    Convert devcoredump to use class_groups instead of class_attrs as that's
    the correct way to handle lists of class attribute files.

    Acked-by: Johannes Berg <johannes@sipsolutions.net>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

So I am reworking the patch file (attached). When I run gentree I get
following:

Traceback (most recent call last):
  File "./gentree.py", line 1091, in <module>
    ret = _main()
  File "./gentree.py", line 724, in _main
    logwrite=logwrite)
  File "./gentree.py", line 906, in process
    apply_patches(args, "backport", source_dir, 'patches',
bpid.target_dir, logwrite)
  File "./gentree.py", line 514, in apply_patches
    raise Exception('No patch content found in %s' % print_name)
Exception: No patch content found in backport-adjustments/devcoredump.patch

However, go into the target dir and applying patch works fine:

$ patch -p1 < ~-/patches/backport-adjustments/devcoredump.patch
patching file compat/drivers-base-devcoredump.c
Hunk #7 succeeded at 181 with fuzz 1 (offset 2 lines).
Hunk #8 succeeded at 248 (offset 2 lines).
Hunk #9 succeeded at 339 (offset 2 lines).
Hunk #10 succeeded at 386 (offset 2 lines).
patching file include/linux/backport-devcoredump.h

So I am a bit puzzled as to what is going on so currently debugging
lib/patch.py. If anyone has a good hint feel free to let me know.

Regards,
Arend

--------------6E5B80DE2D64586D36D5922D
Content-Type: text/plain; charset=UTF-8;
 name="devcoredump.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="devcoredump.patch"

ZGlmZiAtLWdpdCBhL2NvbXBhdC9kcml2ZXJzLWJhc2UtZGV2Y29yZWR1bXAuYyBiL2NvbXBh
dC9kcml2ZXJzLWJhc2UtZGV2Y29yZWR1bXAuYwppbmRleCAyNDAzNzRmLi44YmIzNzZiIDEw
MDY0NAotLS0gYS9jb21wYXQvZHJpdmVycy1iYXNlLWRldmNvcmVkdW1wLmMKKysrIGIvY29t
cGF0L2RyaXZlcnMtYmFzZS1kZXZjb3JlZHVtcC5jCkBAIC0zMSw2ICszMSw3IEBACiAjaW5j
bHVkZSA8bGludXgvc2xhYi5oPgogI2luY2x1ZGUgPGxpbnV4L2ZzLmg+CiAjaW5jbHVkZSA8
bGludXgvd29ya3F1ZXVlLmg+CisjaW5jbHVkZSAiYmFja3BvcnRzLmgiCiAKIHN0YXRpYyBz
dHJ1Y3QgY2xhc3MgZGV2Y2RfY2xhc3M7CiAKQEAgLTQwLDYgKzQxLDEwIEBAIHN0YXRpYyBi
b29sIGRldmNkX2Rpc2FibGVkOwogLyogaWYgZGF0YSBpc24ndCByZWFkIGJ5IHVzZXJzcGFj
ZSBhZnRlciA1IG1pbnV0ZXMgdGhlbiBkZWxldGUgaXQgKi8KICNkZWZpbmUgREVWQ0RfVElN
RU9VVAkoSFogKiA2MCAqIDUpCiAKKyNpZiBMSU5VWF9WRVJTSU9OX0NPREUgPCBLRVJORUxf
VkVSU0lPTigzLDExLDApCitzdGF0aWMgc3RydWN0IGJpbl9hdHRyaWJ1dGUgZGV2Y2RfYXR0
cl9kYXRhOworI2VuZGlmCisKIHN0cnVjdCBkZXZjZF9lbnRyeSB7CiAJc3RydWN0IGRldmlj
ZSBkZXZjZF9kZXY7CiAJdm9pZCAqZGF0YTsKQEAgLTY5LDggKzc0LDcgQEAgc3RhdGljIHZv
aWQgZGV2Y2RfZGV2X3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQogCSAqIGEgc3RydWN0
IGRldmljZSB0byBrbm93IHdoZW4gaXQgZ29lcyBhd2F5PwogCSAqLwogCWlmIChkZXZjZC0+
ZmFpbGluZ19kZXYtPmtvYmouc2QpCi0JCXN5c2ZzX2RlbGV0ZV9saW5rKCZkZXZjZC0+ZmFp
bGluZ19kZXYtPmtvYmosICZkZXYtPmtvYmosCi0JCQkJICAiZGV2Y29yZWR1bXAiKTsKKwkJ
c3lzZnNfcmVtb3ZlX2xpbmsoJmRldmNkLT5mYWlsaW5nX2Rldi0+a29iaiwgImRldmNvcmVk
dW1wIik7CiAKIAlwdXRfZGV2aWNlKGRldmNkLT5mYWlsaW5nX2Rldik7CiAJa2ZyZWUoZGV2
Y2QpOwpAQCAtODIsNiArODYsOSBAQCBzdGF0aWMgdm9pZCBkZXZjZF9kZWwoc3RydWN0IHdv
cmtfc3RydWN0ICp3aykKIAogCWRldmNkID0gY29udGFpbmVyX29mKHdrLCBzdHJ1Y3QgZGV2
Y2RfZW50cnksIGRlbF93ay53b3JrKTsKIAorI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA8IEtF
Uk5FTF9WRVJTSU9OKDMsMTEsMCkKKwlkZXZpY2VfcmVtb3ZlX2Jpbl9maWxlKCZkZXZjZC0+
ZGV2Y2RfZGV2LCAmZGV2Y2RfYXR0cl9kYXRhKTsKKyNlbmRpZgogCWRldmljZV9kZWwoJmRl
dmNkLT5kZXZjZF9kZXYpOwogCXB1dF9kZXZpY2UoJmRldmNkLT5kZXZjZF9kZXYpOwogfQpA
QCAtMTE1LDYgKzEyMiw3IEBAIHN0YXRpYyBzdHJ1Y3QgYmluX2F0dHJpYnV0ZSBkZXZjZF9h
dHRyX2RhdGEgPSB7CiAJLndyaXRlID0gZGV2Y2RfZGF0YV93cml0ZSwKIH07CiAKKyNpZiBM
SU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04oMywxMSwwKQogc3RhdGljIHN0
cnVjdCBiaW5fYXR0cmlidXRlICpkZXZjZF9kZXZfYmluX2F0dHJzW10gPSB7CiAJJmRldmNk
X2F0dHJfZGF0YSwgTlVMTCwKIH07CkBAIC0xMjYsNiArMTM0LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgZGV2Y2RfZGV2X2dyb3VwID0gewogc3RhdGljIGNv
bnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKmRldmNkX2Rldl9ncm91cHNbXSA9IHsKIAkm
ZGV2Y2RfZGV2X2dyb3VwLCBOVUxMLAogfTsKKyNlbmRpZiAvKiBMSU5VWF9WRVJTSU9OX0NP
REUgPj0gS0VSTkVMX1ZFUlNJT04oMywxMSwwKSAqLwogCiBzdGF0aWMgaW50IGRldmNkX2Zy
ZWUoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICpkYXRhKQogewpAQCAtMTcwLDcgKzE3OSwx
MyBAQCBzdGF0aWMgc3RydWN0IGNsYXNzIGRldmNkX2NsYXNzID0gewogCS5uYW1lCQk9ICJk
ZXZjb3JlZHVtcCIsCiAJLm93bmVyCQk9IFRISVNfTU9EVUxFLAogCS5kZXZfcmVsZWFzZQk9
IGRldmNkX2Rldl9yZWxlYXNlLAorI2lmIExJTlVYX1ZFUlNJT05fQ09ERSA+PSBLRVJORUxf
VkVSU0lPTigzLDExLDApCiAJLmRldl9ncm91cHMJPSBkZXZjZF9kZXZfZ3JvdXBzLAorI2Vu
ZGlmCisjaWYgTElOVVhfVkVSU0lPTl9DT0RFIDwgS0VSTkVMX1ZFUlNJT04oNCwxMCwwKQor
IAkuY2xhc3NfYXR0cnMJPSBkZXZjZF9jbGFzc19hdHRycywKKyNlbHNlCgkuY2xhc3NfZ3Jv
dXBzCT0gZGV2Y2RfY2xhc3NfZ3JvdXBzLAorI2VuZGlmCiB9OwogCkBAIC0yMzEsNiArMjQy
LDE0IEBAIHN0YXRpYyB2b2lkIGRldmNkX2ZyZWVfc2d0YWJsZSh2b2lkICpkYXRhKQogCV9k
ZXZjZF9mcmVlX3NndGFibGUoZGF0YSk7CiB9CiAKKyNpZiBMSU5VWF9WRVJTSU9OX0NPREUg
PCBLRVJORUxfVkVSU0lPTigzLDExLDApCitzaXplX3Qgc2dfcGNvcHlfdG9fYnVmZmVyKHN0
cnVjdCBzY2F0dGVybGlzdCAqc2dsLCB1bnNpZ25lZCBpbnQgbmVudHMsCisJCQkgIHZvaWQg
KmJ1Ziwgc2l6ZV90IGJ1Zmxlbiwgb2ZmX3Qgc2tpcCkKK3sKKwlyZXR1cm4gMDsKK30KKyNl
bmRpZgorCiAvKioKICAqIGRldmNkX3JlYWRfZnJvbV90YWJsZSAtIGNvcHkgZGF0YSBmcm9t
IHNnX3RhYmxlIHRvIGEgZ2l2ZW4gYnVmZmVyCiAgKiBhbmQgcmV0dXJuIHRoZSBudW1iZXIg
b2YgYnl0ZXMgcmVhZApAQCAtMzE0LDYgKzMzMywxMSBAQCB2b2lkIGRldl9jb3JlZHVtcG0o
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbW9kdWxlICpvd25lciwKIAlpZiAoZGV2aWNl
X2FkZCgmZGV2Y2QtPmRldmNkX2RldikpCiAJCWdvdG8gcHV0X2RldmljZTsKIAorI2lmIExJ
TlVYX1ZFUlNJT05fQ09ERSA8IEtFUk5FTF9WRVJTSU9OKDMsMTEsMCkKKwlpZiAoZGV2aWNl
X2NyZWF0ZV9iaW5fZmlsZSgmZGV2Y2QtPmRldmNkX2RldiwgJmRldmNkX2F0dHJfZGF0YSkp
CisJCWdvdG8gcHV0X2RldmljZTsKKyNlbmRpZgorCiAJaWYgKHN5c2ZzX2NyZWF0ZV9saW5r
KCZkZXZjZC0+ZGV2Y2RfZGV2LmtvYmosICZkZXYtPmtvYmosCiAJCQkgICAgICAiZmFpbGlu
Z19kZXZpY2UiKSkKIAkJLyogbm90aGluZyAtIHN5bWxpbmsgd2lsbCBiZSBtaXNzaW5nICov
OwpAQCAtMzU2LDE1ICszODAsMTMgQEAgdm9pZCBkZXZfY29yZWR1bXBzZyhzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBzY2F0dGVybGlzdCAqdGFibGUsCiB9CiBFWFBPUlRfU1lNQk9M
X0dQTChkZXZfY29yZWR1bXBzZyk7CiAKLXN0YXRpYyBpbnQgX19pbml0IGRldmNvcmVkdW1w
X2luaXQodm9pZCkKK2ludCBfX2luaXQgZGV2Y29yZWR1bXBfaW5pdCh2b2lkKQogewogCXJl
dHVybiBjbGFzc19yZWdpc3RlcigmZGV2Y2RfY2xhc3MpOwogfQotX19pbml0Y2FsbChkZXZj
b3JlZHVtcF9pbml0KTsKIAotc3RhdGljIHZvaWQgX19leGl0IGRldmNvcmVkdW1wX2V4aXQo
dm9pZCkKK3ZvaWQgX19leGl0IGRldmNvcmVkdW1wX2V4aXQodm9pZCkKIHsKIAljbGFzc19m
b3JfZWFjaF9kZXZpY2UoJmRldmNkX2NsYXNzLCBOVUxMLCBOVUxMLCBkZXZjZF9mcmVlKTsK
IAljbGFzc191bnJlZ2lzdGVyKCZkZXZjZF9jbGFzcyk7CiB9Ci1fX2V4aXRjYWxsKGRldmNv
cmVkdW1wX2V4aXQpOwotLS0gYS9pbmNsdWRlL2xpbnV4L2JhY2twb3J0LWRldmNvcmVkdW1w
LmgKKysrIGIvaW5jbHVkZS9saW51eC9iYWNrcG9ydC1kZXZjb3JlZHVtcC5oCkBAIC02Niw3
ICs2Niw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBfZGV2Y2RfZnJlZV9zZ3RhYmxlKHN0cnVj
dCBzY2F0dGVybGlzdCAqdGFibGUpCiB9CiAKIAotI2lmZGVmIENPTkZJR19ERVZfQ09SRURV
TVAKKyNpZmRlZiBDUFRDRkdfQlBBVVRPX1dBTlRfREVWX0NPUkVEVU1QCiB2b2lkIGRldl9j
b3JlZHVtcHYoc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICpkYXRhLCBzaXplX3QgZGF0YWxl
biwKIAkJICAgZ2ZwX3QgZ2ZwKTsKIApAQCAtMTAwLDYgKzEwMCw2IEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCBkZXZfY29yZWR1bXBzZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBzY2F0
dGVybGlzdCAqdGFibGUsCiB7CiAJX2RldmNkX2ZyZWVfc2d0YWJsZSh0YWJsZSk7CiB9Ci0j
ZW5kaWYgLyogQ09ORklHX0RFVl9DT1JFRFVNUCAqLworI2VuZGlmIC8qIENQVENGR19CUEFV
VE9fV0FOVF9ERVZfQ09SRURVTVAgKi8KIAogI2VuZGlmIC8qIF9fREVWQ09SRURVTVBfSCAq
Lwo=
--------------6E5B80DE2D64586D36D5922D--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
