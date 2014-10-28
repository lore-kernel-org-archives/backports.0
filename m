Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:48886 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaJ1Sbi (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 Oct 2014 14:31:38 -0400
Received: by mail-la0-f44.google.com with SMTP id gf13so1185359lab.17
        for <backports@vger.kernel.org>; Tue, 28 Oct 2014 11:31:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0BA3FCBA62E2DC44AF3030971E174FB31B55873E@hasmsx107.ger.corp.intel.com>
References: <0BA3FCBA62E2DC44AF3030971E174FB31B55873E@hasmsx107.ger.corp.intel.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 28 Oct 2014 11:31:17 -0700
Message-ID: <CAB=NE6XBgHMNyLLS3wwYUh70sugbY0+YrKoBckk5O-tXF68t4Q@mail.gmail.com> (sfid-20141028_193140_666443_0E1BADA9)
Subject: Re: failure to build backports on ubuntu
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Oct 28, 2014 at 10:08 AM, Grumbach, Emmanuel
<emmanuel.grumbach@intel.com> wrote:
>
> I can't make menuconfig. Reverting this patch fixes it.

There's no context provided here, gcc version, Linux distribution,
etc. With some of that it would help.

 Luis
