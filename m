Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:46046 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755724AbaDLBru (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 21:47:50 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so5971451pdi.33
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 18:47:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1397266475-14442-9-git-send-email-mcgrof@do-not-panic.com>
References: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com> <1397266475-14442-9-git-send-email-mcgrof@do-not-panic.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 11 Apr 2014 18:41:35 -0700
Message-ID: <CAB=NE6XbzG-AURbRnXpPLFi7+C0pOJLJOUmZAMWb9LupUa4-Ww@mail.gmail.com> (sfid-20140412_034752_472888_E5E4AFCF)
Subject: Re: [PATCH 08/10] backports: bump bluetooth reqs to 3.2
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Apr 11, 2014 at 6:34 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> As a prep to bump general requirements lets bump bluetooth
> minimum kernel requirements to at least 3.2.

Ignore this, it gets on 3.0 as the minimum requirements as I later
removed this line, and that means it default to the oldest supported
kernel, which is 3.0 now.

  Luis
