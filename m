Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:13165 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaLCOIH (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 3 Dec 2014 09:08:07 -0500
Message-ID: <547F1942.5060502@broadcom.com> (sfid-20141203_150829_105637_D2D75362)
Date: Wed, 3 Dec 2014 15:08:02 +0100
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: SF Markus Elfring <elfring@users.sourceforge.net>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
	Julia Lawall <julia.lawall@lip6.fr>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Coccinelle <cocci@systeme.lip6.fr>, <backports@vger.kernel.org>,
	"Johannes Berg" <johannes@sipsolutions.net>,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [patch] CodingStyle: add some more error handling guidelines
References: <20141202085950.GA13434@mwanda> <547F0297.6030202@users.sourceforge.net> <20141203124511.GR5048@mwanda> <547F0977.7090908@users.sourceforge.net> <20141203132002.GT5048@mwanda> <547F0F2A.3060708@users.sourceforge.net>
In-Reply-To: <547F0F2A.3060708@users.sourceforge.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/03/14 14:24, SF Markus Elfring wrote:
>> Sorry.  I misread your email.  If the code looks like this:
>>
>> 	foo = kmalloc();
>> 	if (!foo)
>> 		goto kmalloc_failed;
>>
>> The "kmalloc_failed" doesn't add any information.
>
> I find that this such a name approach would fit to your
> expectation of a source-oriented labeling of these identifiers.
>
>
>> We can see that kmalloc failed from the context.
>
> Which name pattern do you find more appropriate in such
> an use case?

I think Dan wants the label to be descriptive about the tasks needed in 
the exception handling itself. This makes sense as the exception 
handling steps may be reused for different failures in the code.

void foo(void)
{
	if (check_a())
		goto do_bar;

	sub_foo1();

	if (checck_b())
		goto do_bar;

	sub_foo2();
	return;

do_bar:
	bar();
}

Regards,
Arend

> Regards,
> Markus
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

