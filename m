Return-path: <backports-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:63885 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738AbaLCMva (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 3 Dec 2014 07:51:30 -0500
Message-ID: <547F0741.1090808@users.sourceforge.net> (sfid-20141203_135148_155989_DCF167C9)
Date: Wed, 03 Dec 2014 13:51:13 +0100
From: SF Markus Elfring <elfring@users.sourceforge.net>
MIME-Version: 1.0
To: Arend van Spriel <arend@broadcom.com>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
	Julia Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Coccinelle <cocci@systeme.lip6.fr>, backports@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [patch] CodingStyle: add some more error handling guidelines
References: <20141202085950.GA13434@mwanda> <547F0297.6030202@users.sourceforge.net> <547F0465.407@broadcom.com>
In-Reply-To: <547F0465.407@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

>> * To which source code place should the word "location" refer to?
>>    - jump source
>>    - jump target
> 
> I think you digested the paragraph in too small bits.

I would prefer to reduce the probability for misunderstandings of the 
proposed wording a bit more.


> The term "goto location" looks synonymous to "jump source" to me.

I would interpret it differently because of the specific placement of this key word
before an other term.

Regards,
Markus
