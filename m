Return-path: <backports-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:43328 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbaLCTOQ (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 3 Dec 2014 14:14:16 -0500
Message-ID: <547F60E5.50705@broadcom.com> (sfid-20141203_201436_165170_9D143D00)
Date: Wed, 3 Dec 2014 20:13:41 +0100
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
References: <20141202085950.GA13434@mwanda> <547F0297.6030202@users.sourceforge.net> <20141203124511.GR5048@mwanda> <547F0977.7090908@users.sourceforge.net> <20141203132002.GT5048@mwanda> <547F0F2A.3060708@users.sourceforge.net> <547F1942.5060502@broadcom.com> <547F33AC.50002@users.sourceforge.net>
In-Reply-To: <547F33AC.50002@users.sourceforge.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/03/14 17:00, SF Markus Elfring wrote:
>>> Which name pattern do you find more appropriate in such
>>> an use case?
>>
>> I think Dan wants the label to be descriptive about the tasks
>> needed in the exception handling itself.
>
> I would usually prefer also such a target-oriented labelling
> for the affected identifiers.
> How are the chances to express an expectation in this direction
> unambiguously for the proposed coding style update?
>
>
>> This makes sense as the exception handling steps may be reused
>> for different failures in the code.
>
> I would stress a different reason from my point of view.

I meant as apposed to using a goto-/source-oriented labelling. Please 
provide your point of view. That way the explanations given in this 
email exchange might be incorporated in the next round of the proposed 
update or at least be used as input.

Regards,
Arend
