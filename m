Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:43435 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbaDRADq (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 17 Apr 2014 20:03:46 -0400
Received: by mail-la0-f44.google.com with SMTP id c6so911575lan.17
        for <backports@vger.kernel.org>; Thu, 17 Apr 2014 17:03:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1397571929-29929-1-git-send-email-arend@broadcom.com>
References: <1397571929-29929-1-git-send-email-arend@broadcom.com>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Thu, 17 Apr 2014 17:03:24 -0700
Message-ID: <CAB=NE6VtA11u_drZrJrq0v5Q4Qo=oiej+drkYc77E2zsc60g2A@mail.gmail.com> (sfid-20140418_020348_800504_FD7A2536)
Subject: Re: [PATCH] backports: patches: fix flow_dissector patch for 3.15-rc1
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 15, 2014 at 7:25 AM, Arend van Spriel <arend@broadcom.com> wrote:
> The flow_dissector patch did not apply backporting 3.15-rc1 kernel
> sources based on wireless-testing repository. Fixing up the patch.
>
> Signed-off-by: Arend van Spriel <arend@broadcom.com>

Thanks so much ! I had addressed this exact change earlier on April 11
and sent out the patch. The other changes I pushed out today are
needed for a full v3.15 branch, it seems things are compiling for
v3.15 now, will poke the list with details once verified completely.

  Luis
