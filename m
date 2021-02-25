Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_EPI,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D2AC433DB
	for <backports@archiver.kernel.org>; Thu, 25 Feb 2021 08:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 530EB64EDB
	for <backports@archiver.kernel.org>; Thu, 25 Feb 2021 08:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbhBYIpF (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 25 Feb 2021 03:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhBYIpE (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 25 Feb 2021 03:45:04 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547CFC061574
        for <backports@vger.kernel.org>; Thu, 25 Feb 2021 00:44:24 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o6so3116108pjf.5
        for <backports@vger.kernel.org>; Thu, 25 Feb 2021 00:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=wSa0rBIVeeZ3dfeMm3QLh0tQ6CulB8eHz9S03M/HBLI=;
        b=h+Zll3yfrH1MJYaav8L2NtzxY4Vnt5R3ZezRP8ZwV16g2iLt7BZgtKSyKBRCWsI27v
         Es26x6JYwBVq9NVbszFqi+CuLdFvPbQ9eYZY0UvvjCJFlZ629RPeAbI7c27EKHOhSPPL
         ycUkU6bJTF4/8DzfBy9MwrR7oDxZgKh/Ff13Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=wSa0rBIVeeZ3dfeMm3QLh0tQ6CulB8eHz9S03M/HBLI=;
        b=suXokdh8imo3QbgU7MwbvnPkHXLy67/Bnm0wMa2o1XIYkZ3aoOlxx1djtlI8o2da9R
         4x4VOpc5S7zVm6q5Z5bncBfiBm85gMubcO2w378yUn9m/QeYJhMiXndGF/wjsM5khacA
         5Kri6+QOxEoopPT7Q/Zd68NtNSATOUv1Xc+EUmD2zdx6/BmPwSZX5ab4mL9ZuGC2CXzS
         NzLp36/yUVW492f6LF5L7SolsBPYjBgdf0t6tzkghrfIJfXBlw4UwIVegNw5bv7r28//
         GuO0ympYf623MQ3DIdTBXmv9MUJ1SH7Frr/y24yZQzw/fdcoyR3HsF414Ds38oQrJZt/
         yhOg==
X-Gm-Message-State: AOAM530Lh3mTt3drZQywyqaEWcxOI5Rm0xPFe5qP29cV36lSzHaN7nUM
        nKJhe5jc/r8rQqpEGjW7xYgc7SxIVxcJfoT6eOeqLaNhe9bGuDMllDz6zJ1BQSa0J3HvrnjaYL2
        WfX9ULQSDISXyt5QvcT9h4nHgvT2IS2hTrHZK052pGPLwc/czJlvjt3mlsF59b1ZvmF13GWQwVo
        ooieSmYrl74pyQ
X-Google-Smtp-Source: ABdhPJwquTniOGgEi0N562u5X0FzWDG18cHMDxIMVSeW4JbbMYeaCoIdjnXNI8OAUA/4R+yIkvOtMQ==
X-Received: by 2002:a17:90a:de06:: with SMTP id m6mr2228741pjv.184.1614242663461;
        Thu, 25 Feb 2021 00:44:23 -0800 (PST)
Received: from [10.230.42.155] ([192.19.152.250])
        by smtp.gmail.com with ESMTPSA id b10sm5120623pgm.76.2021.02.25.00.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 00:44:23 -0800 (PST)
Subject: Re: backports Kconfig processing
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     backports@vger.kernel.org
References: <a3926220-cc2c-5feb-0017-bf8793184cea@broadcom.com>
 <0dfe67b7019ec7971244d5e2813f9b6c1a558524.camel@sipsolutions.net>
 <842e7a1b-8a48-a6d0-3fe4-ca76b85e6218@broadcom.com>
 <1aae3fb1963fc525a587dbef7317ebc0fd988f0f.camel@sipsolutions.net>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <1bc87970-6521-63c5-6736-8fd850ee591d@broadcom.com>
Date:   Thu, 25 Feb 2021 09:44:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1aae3fb1963fc525a587dbef7317ebc0fd988f0f.camel@sipsolutions.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008ffb4e05bc25280f"
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

--0000000000008ffb4e05bc25280f
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US

On 25-02-2021 09:42, Johannes Berg wrote:
> On Thu, 2021-02-25 at 09:31 +0100, Arend van Spriel wrote:
>>
>> On 24-02-2021 15:32, Johannes Berg wrote:
>>> Hi Arend,
>>>
>>>> I was made aware that the select line in brcm80211 Kconfig is not
>>>> working in backports:
>>>>
>>>> select WANT_DEV_COREDUMP if BRCMFMAC
>>>>
>>>> Is this something that can be fixed in backports?
>>>
>>> I guess it can be, but what do you mean by "not working"?
>>>
>>> It should be rewritten to
>>>
>>> select BPAUTO_WANT_DEV_COREDUMP if BRCMFMAC
>>>
>>> but quite possibly the parser doesn't understand the " if BRCMFMAC" part
>>> there.
>>
>> That exactly what is being reported. Things were working fine until I
>> added the "if BRCMFMAC" part.
> 
> Yeah, so lib/kconfig.py has this
> 
> sel_line = re.compile(r'^(?P<spc>\s+)select\s+(?P<sym>[^\s]*)\s*$')
> 
> which doesn't cover the case of "if ..." on the select line.
> 
> I guess you could either look at that and fix it - need to fix the regex
> to allow all_selects() to find it, and modify_selects() to preserve the
> "if ..." part.
> 
> Probably something like
> 
> diff --git a/lib/kconfig.py b/lib/kconfig.py
> index a77f8a54eea7..46df636d7594 100644
> --- a/lib/kconfig.py
> +++ b/lib/kconfig.py
> @@ -8,7 +8,7 @@ src_line_rel = re.compile(r'^\s*source\s+(?P<src>[^\s"]*)"?\s*$')
>   tri_line = re.compile(r'^(?P<spc>\s+)tristate')
>   bool_line = re.compile(r'^(?P<spc>\s+)bool')
>   cfg_line = re.compile(r'^(?P<opt>config|menuconfig)\s+(?P<sym>[^\s]*)')
> -sel_line = re.compile(r'^(?P<spc>\s+)select\s+(?P<sym>[^\s]*)\s*$')
> +sel_line = re.compile(r'^(?P<spc>\s+)select\s+(?P<sym>[^\s]*)(?P<ifexpr>.*)$')
>   backport_line = re.compile(r'^\s+#(?P<key>[ch]-file|module-name)\s*(?P<name>.*)')
>   
>   class ConfigTree(object):
> @@ -230,9 +230,9 @@ class ConfigTree(object):
>                   m = sel_line.match(l)
>                   if m and not m.group('sym') in syms:
>                       if 'BPAUTO_' + m.group('sym') in syms:
> -                        out += m.group('spc') + "select BPAUTO_" + m.group('sym') + '\n'
> +                        out += m.group('spc') + "select BPAUTO_" + m.group('sym') + m.group('ifexpr') + '\n'
>                       else:
> -                        out += m.group('spc') + "depends on " + m.group('sym') + '\n'
> +                        out += m.group('spc') + "depends on " + m.group('sym') + m.group('ifexpr') + '\n'
>                   else:
>                       out += l
>               outf = open(os.path.join(self.bpid.target_dir, nf), 'w')

Thanks for the suggestion. I will give it a try.

Regards,
Arend

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--0000000000008ffb4e05bc25280f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
XSlOP9s1dqWlRRnnNxV7BVC87lkKKy0+1M2DOF6qRYQlnW4EfOyCToYLAG5zeV+AjepMoX6J9bUz
yj4BlDtwH4HFjaRIlPPbdLshUA54/tV84x8woATuLGBq+hTZEpkZAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFKb+3b9pz8zo
0QsCHGb/p0UrBlU+MA0GCSqGSIb3DQEBCwUAA4IBAQCHisuRNqP0NfYfG3U3XF+bocf//aGLOCGj
NvbnSbaUDT/ZkRFb9dQfDRVnZUJ7eDZWHfC+kukEzFwiSK1irDPZQAG9diwy4p9dM0xw5RXSAC1w
FzQ0ClJvhK8PsjXF2yzITFmZsEhYEToTn2owD613HvBNijAnDDLV8D0K5gtDnVqkVB9TUAGjHsmo
aAwIDFKdqL0O19Kui0WI1qNsu1tE2wAZk0XE9FG0OKyY2a2oFwJ85c5IO0q53U7+YePIwv4/J5aP
OGM6lFPJCVnfKc3H76g/FyPyaE4AL/hfdNP8ObvCB6N/BVCccjNdglRsL2ewttAG3GM06LkvrLhv
UCvjMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMMSnY
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAXqPVczyQmnuvU2rF2
t4o2WbzxXAR54ZRuyiCurAqeVTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMTAyMjUwODQ0MjNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAAfxzAfM7gpfH58uGLm5ZhS/evrdEl7yT9ZdJ
vFKm8ot6keSdDm2vef8/PsaeydsXVX+Vn6wCSgZ243PQCwhyRU88+nCNZ3fpziiqlEMR24wnJNAz
thOOxqC1X6UijeR6dhtdA5FMvJK5m1u0EpJJzFxQvMYIvmFII8V9QC6NTOnGALxRiqLZjSDhndqz
8eG8V4W8xlzvxYHNTmtkRt2tCEoYwE0wPmd3QLnH6WnXz0ZWRCFtkv3KlXW2cIThTY8Bc1jMbVnN
PYj9TIT5/HNaefDKeVUAExkpFoqP1TXwsUOtzn3NMb2EFqA71FFPEYHkIPMMWpc4NHa0rPmaiwcR
SQ==
--0000000000008ffb4e05bc25280f--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
