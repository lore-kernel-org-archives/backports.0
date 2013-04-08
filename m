Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:54062 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965060Ab3DHU4e (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 16:56:34 -0400
Message-ID: <1365454577.25475.27.camel@jlt4.sipsolutions.net> (sfid-20130408_225700_937081_D5F0B880)
Subject: Re: [PATCH v3 8/8] build: add NFC defconfig file
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: Thierry Escande <thierry.escande@linux.intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Mon, 08 Apr 2013 22:56:17 +0200
In-Reply-To: <CAB=NE6XzZvJcGb4xLZN7QKrCiYDMN0JN=uU8VR5yGUkyWS9uTw@mail.gmail.com> (sfid-20130408_225206_192759_DF72C17C)
References: <1365416773-12836-9-git-send-email-thierry.escande@linux.intel.com>
	 <CAB=NE6WWA4r+FyqR484ZJJm_usrCRDOjzMut-6JawNXJXUNmvw@mail.gmail.com>
	 <1365449679.25475.18.camel@jlt4.sipsolutions.net>
	 <CAB=NE6X6+M2-eUeqTv-PAJDQ_VaLwUv3n94J1YTR+4CK7YYdaw@mail.gmail.com>
	 <1365450036.25475.21.camel@jlt4.sipsolutions.net>
	 <CAB=NE6XzZvJcGb4xLZN7QKrCiYDMN0JN=uU8VR5yGUkyWS9uTw@mail.gmail.com>
	 (sfid-20130408_225206_192759_DF72C17C)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-04-08 at 13:51 -0700, Luis R. Rodriguez wrote:

> > So the default is just whatever the default is in the Kconfig files,
> > which is essentially everything else turned off.
> 
> Odd, when I tried to do media with similar defconfig I got wireless
> building :( but its great this was the goal, I'll try again.

Did you create a new tree or rm .config first?

johannes

