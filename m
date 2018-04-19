Return-path: <backports-owner@vger.kernel.org>
Received: from mail-by2nam03on0103.outbound.protection.outlook.com ([104.47.42.103]:33760
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751135AbeDSICm (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 19 Apr 2018 04:02:42 -0400
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: [PATCH] backports: rename *-asn1.[ch] to *.asn1.[ch]
To: Johannes Berg <johannes@sipsolutions.net>,
        Winnie Chang <winnie.chang@cypress.com>,
        backports@vger.kernel.org
Cc: chln@cypress.com
References: <20180419061146.GA22072@aremote01.aus.cypress.com>
 <1524123197.3024.13.camel@sipsolutions.net>
From: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <91215546-664c-4714-9a36-aaf6edc35429@cypress.com> (sfid-20180419_100249_683894_C1AC75D6)
Date: Thu, 19 Apr 2018 16:02:33 +0800
MIME-Version: 1.0
In-Reply-To: <1524123197.3024.13.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


On 04/19/2018 3:33, Johannes Berg wrote:
> On Thu, 2018-04-19 at 01:11 -0500, Winnie Chang wrote:
>> linux-stable 4fa8bc949de11c99ee2433c602d43f87c452f4f2 renamed
>> *-asn1.[ch] files to *.asn1.[ch]. Make the corresponding change
>> for backports.
> 
> Does it matter? I mean, I don't really mind the patch, but I also see
> little reason for it?

Johannes,

Thanks for reviewing.

The linux-stable file rename has caused build failure. It's because 
backports pulls kernel pkcs7_parser.c, which includes the renamed header 
file pkcs7.asn1.h, while our corresponding copy in backports.git still 
has the old name pkcs7-asn1.h.

Here's the copy-list line that pulls pkcs_parser.c:
crypto/asymmetric_keys/pkcs7_parser.c -> compat/verification/pkcs7_parser.c

Chi-hsien Lin

> 
> johannes
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> .
> 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
